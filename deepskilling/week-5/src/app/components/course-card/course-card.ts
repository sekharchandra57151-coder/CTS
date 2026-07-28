import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { Course } from '../../models/course.model';
import { CreditLabelPipe } from '../../pipes/credit-label-pipe';
import { Store } from '@ngrx/store';
import { map, Observable, of, take } from 'rxjs';
import { enrollInCourse, unenrollFromCourse } from '../../store/enrollment/enrollment.actions';
import { selectEnrolledIds } from '../../store/enrollment/enrollment.selectors';

@Component({
  selector: 'app-course-card',
  imports: [CommonModule, CreditLabelPipe],
  templateUrl: './course-card.html',
  styleUrl: './course-card.css',
})
export class CourseCard implements OnChanges {
  @Input({ required: true }) course!: Course;
  @Output() enrollRequested = new EventEmitter<number>();
  @Output() courseSelected = new EventEmitter<number>();
  isExpanded = false;

  isEnrolled$: Observable<boolean> = of(false);

  constructor(private readonly store: Store) {}

  // Keeping conditional styles in a getter makes the template easier to read and maintain.
  get cardClasses(): Record<string, boolean> {
    return {
      'card--enrolled': false,
      'card--full': this.course.credits >= 4,
      expanded: this.isExpanded,
    };
  }

  get borderColor(): string {
    switch (this.course.gradeStatus) {
      case 'passed':
        return 'green';
      case 'failed':
        return 'red';
      default:
        return 'grey';
    }
  }

  toggleDetails(event: MouseEvent): void {
    event.stopPropagation();
    this.isExpanded = !this.isExpanded;
  }

  toggleEnrollment(event: MouseEvent): void {
    event.stopPropagation();
    this.store.select(selectEnrolledIds).pipe(take(1)).subscribe((enrolledIds) =>
      this.store.dispatch(enrolledIds.includes(this.course.id) ? unenrollFromCourse({ courseId: this.course.id }) : enrollInCourse({ courseId: this.course.id })),
    );
    this.enrollRequested.emit(this.course.id);
  }

  ngOnChanges(changes: SimpleChanges): void {
    const courseChange = changes['course'];

    if (courseChange) {
      this.isEnrolled$ = this.store.select(selectEnrolledIds).pipe(map((ids) => ids.includes(this.course.id)));
      console.log('Course input changed:', {
        previous: courseChange.previousValue,
        current: courseChange.currentValue,
      });
    }
  }
}
