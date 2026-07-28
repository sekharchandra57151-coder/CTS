import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Course } from '../../models/course.model';
import { CourseService } from '../../services/course';

@Component({
  selector: 'app-course-detail',
  imports: [CommonModule],
  templateUrl: './course-detail.html',
  styleUrl: './course-detail.css',
})
export class CourseDetail {
  course?: Course;
  errorMessage = '';

  constructor(
    private readonly route: ActivatedRoute,
    private readonly courseService: CourseService,
  ) {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    this.courseService.getCourseById(id).subscribe({
      next: (course) => (this.course = course),
      error: (error) => (this.errorMessage = error.message),
    });
  }
}
