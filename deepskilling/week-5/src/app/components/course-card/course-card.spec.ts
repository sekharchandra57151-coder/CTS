import { ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { MockStore, provideMockStore } from '@ngrx/store/testing';
import { SimpleChange } from '@angular/core';
import { vi } from 'vitest';
import { of } from 'rxjs';
import { Course } from '../../models/course.model';
import { selectEnrolledIds } from '../../store/enrollment/enrollment.selectors';
import { CourseCard } from './course-card';

describe('CourseCard', () => {
  let component: CourseCard;
  let fixture: ComponentFixture<CourseCard>;
  let store: MockStore;
  const mockCourse: Course = { id: 1, name: 'Data Structures', code: 'CS101', credits: 4, gradeStatus: 'passed' };

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CourseCard],
      providers: [provideMockStore({ initialState: { enrollment: { enrolledCourseIds: [] } } })],
    }).compileComponents();

    fixture = TestBed.createComponent(CourseCard);
    component = fixture.componentInstance;
    store = TestBed.inject(MockStore);
  });

  it('should create', () => expect(component).toBeTruthy());

  it('renders the course supplied through @Input', () => {
    component.course = mockCourse;
    fixture.detectChanges();
    expect(fixture.debugElement.query(By.css('h2')).nativeElement.textContent).toContain('Data Structures');
  });

  it('emits the course ID when Enroll is clicked', () => {
    component.course = mockCourse;
    fixture.detectChanges();
    const emitSpy = vi.spyOn(component.enrollRequested, 'emit');

    fixture.debugElement.query(By.css('button')).nativeElement.click();

    expect(emitSpy).toHaveBeenCalledWith(1);
  });

  it('shows Unenroll when its enrollment observable emits true', () => {
    vi.spyOn(component, 'ngOnChanges').mockImplementation(() => undefined);
    component.course = mockCourse;
    component.isEnrolled$ = of(true);
    fixture.detectChanges();
    expect(fixture.debugElement.query(By.css('button')).nativeElement.textContent).toContain('Unenroll');
  });

  it('logs course input changes in ngOnChanges', () => {
    component.course = mockCourse;
    const logSpy = vi.spyOn(console, 'log').mockImplementation(() => undefined);

    component.ngOnChanges({ course: new SimpleChange(undefined, mockCourse, true) });

    expect(logSpy).toHaveBeenCalledWith('Course input changed:', expect.objectContaining({ current: mockCourse }));
    logSpy.mockRestore();
  });
});
