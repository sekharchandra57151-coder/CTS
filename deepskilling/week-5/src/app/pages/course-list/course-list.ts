import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CourseCard } from '../../components/course-card/course-card';
import { Highlight } from '../../directives/highlight';
import { Course } from '../../models/course.model';
import { CourseService } from '../../services/course';
import { EnrollmentService } from '../../services/enrollment';
import { Student } from '../../models/enrollment.model';
import { Subject, switchMap } from 'rxjs';
import { Store } from '@ngrx/store';
import { loadCourses } from '../../store/course/course.actions';
import { selectAllCourses, selectCoursesError, selectCoursesLoading } from '../../store/course/course.selectors';

@Component({
  selector: 'app-course-list',
  imports: [CommonModule, FormsModule, CourseCard, Highlight],
  templateUrl: './course-list.html',
  styleUrl: './course-list.css',
})
export class CourseList implements OnInit {
  readonly courses$;
  readonly isLoading$;
  readonly errorMessage$;
  selectedCourseId?: number;
  selectedStudents: Student[] = [];
  searchTerm = '';
  errorMessage = '';
  private readonly courseSelection$ = new Subject<number>();

  constructor(
    private readonly courseService: CourseService,
    private readonly enrollmentService: EnrollmentService,
    private readonly store: Store,
    private readonly router: Router,
    private readonly route: ActivatedRoute,
  ) {
    this.courses$ = this.store.select(selectAllCourses);
    this.isLoading$ = this.store.select(selectCoursesLoading);
    this.errorMessage$ = this.store.select(selectCoursesError);
  }

  ngOnInit(): void {
    this.searchTerm = this.route.snapshot.queryParamMap.get('search') ?? '';
    this.store.dispatch(loadCourses());

    // switchMap cancels a prior student request when another course is selected.
    this.courseSelection$
      .pipe(switchMap((courseId) => this.enrollmentService.getStudentsByCourse(courseId)))
      .subscribe({ next: (students) => (this.selectedStudents = students) });
  }

  onEnroll(courseId: number): void {
    console.log('Enrolling in course: ' + courseId);
    this.selectedCourseId = courseId;
    this.courseSelection$.next(courseId);
  }

  addSampleCourse(): void {
    this.courseService.createCourse({
      name: 'New Shared Course',
      code: `NEW${Date.now().toString().slice(-4)}`,
      credits: 3,
      gradeStatus: 'pending',
    }).subscribe({ next: () => this.store.dispatch(loadCourses()), error: (error) => (this.errorMessage = error.message) });
  }

  deleteCourse(courseId: number): void {
    this.courseService.deleteCourse(courseId).subscribe({
      next: () => this.store.dispatch(loadCourses()),
      error: (error) => (this.errorMessage = error.message),
    });
  }

  openCourse(courseId: number): void {
    this.router.navigate(['courses', courseId]);
  }

  onSearchChange(): void {
    this.router.navigate(['courses'], {
      queryParams: { search: this.searchTerm || null },
    });
  }

  // trackBy preserves existing DOM nodes when the array changes, avoiding unnecessary re-rendering.
  trackByCourseId(index: number, course: Course): number {
    return course.id;
  }
}
