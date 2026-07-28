import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';
import { Course } from '../models/course.model';
import { CourseService } from './course';

describe('CourseService', () => {
  let service: CourseService;
  let httpMock: HttpTestingController;
  const mockCourses: Course[] = [
    { id: 1, name: 'Data Structures', code: 'CS101', credits: 4, gradeStatus: 'passed' },
    { id: 2, name: 'Unavailable Course', code: 'CS000', credits: 0, gradeStatus: 'pending' },
    { id: 3, name: 'Algorithms', code: 'CS102', credits: 3, gradeStatus: 'pending' },
  ];

  beforeEach(() => {
    TestBed.configureTestingModule({ providers: [CourseService, provideHttpClient(), provideHttpClientTesting()] });
    service = TestBed.inject(CourseService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => httpMock.verify());

  it('loads courses from the expected URL and filters zero-credit courses', () => {
    service.getCourses().subscribe((courses) => expect(courses.length).toBe(2));
    httpMock.expectOne('http://localhost:3000/courses').flush(mockCourses);
  });

  it('returns a friendly error after retrying failed requests', () => {
    let receivedError: Error | undefined;
    service.getCourses().subscribe({ error: (error) => (receivedError = error) });

    for (let attempt = 0; attempt < 3; attempt++) {
      httpMock.expectOne('http://localhost:3000/courses').flush('Server failure', { status: 500, statusText: 'Server Error' });
    }

    expect(receivedError?.message).toBe('Failed to load courses. Please try again.');
  });
});
