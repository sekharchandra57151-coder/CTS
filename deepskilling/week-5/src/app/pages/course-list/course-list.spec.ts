import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute, Router } from '@angular/router';
import { provideMockStore, MockStore } from '@ngrx/store/testing';
import { of } from 'rxjs';
import { Course } from '../../models/course.model';
import { CourseService } from '../../services/course';
import { EnrollmentService } from '../../services/enrollment';
import { CourseList } from './course-list';

describe('CourseList', () => {
  let component: CourseList;
  let fixture: ComponentFixture<CourseList>;
  let store: MockStore;
  const mockCourses: Course[] = [
    { id: 1, name: 'Data Structures', code: 'CS101', credits: 4, gradeStatus: 'passed' },
    { id: 2, name: 'Algorithms', code: 'CS102', credits: 3, gradeStatus: 'pending' },
  ];
  const initialState = {
    course: { courses: mockCourses, loading: false, error: null },
    enrollment: { enrolledCourseIds: [] },
  };

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CourseList],
      providers: [
        provideMockStore({ initialState }),
        { provide: CourseService, useValue: { createCourse: () => of(), deleteCourse: () => of() } },
        { provide: EnrollmentService, useValue: { getStudentsByCourse: () => of([]) } },
        { provide: Router, useValue: { navigate: () => Promise.resolve(true) } },
        { provide: ActivatedRoute, useValue: { snapshot: { queryParamMap: { get: () => null } } } },
      ],
    }).compileComponents();

    fixture = TestBed.createComponent(CourseList);
    component = fixture.componentInstance;
    store = TestBed.inject(MockStore);
  });

  it('renders one course card for each course in MockStore', () => {
    fixture.detectChanges();
    expect(fixture.nativeElement.querySelectorAll('app-course-card').length).toBe(2);
  });

  it('displays the loading indicator when MockStore is loading', () => {
    store.setState({ ...initialState, course: { courses: [], loading: true, error: null } });
    fixture.detectChanges();
    expect(fixture.nativeElement.textContent).toContain('Loading courses...');
  });
});
