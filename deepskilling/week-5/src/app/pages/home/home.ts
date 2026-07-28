import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CourseSummaryWidget } from '../../components/course-summary-widget/course-summary-widget';
import { Notification } from '../../components/notification/notification';
import { CourseService } from '../../services/course';

@Component({
  selector: 'app-home',
  imports: [FormsModule, CourseSummaryWidget, Notification],
  templateUrl: './home.html',
  styleUrl: './home.css',
})
export class Home implements OnInit, OnDestroy {
  portalName = 'Student Course Portal';
  isPortalActive = true;
  message = '';
  searchTerm = '';
  availableCourses = 0;
  constructor(private readonly courseService: CourseService) {}

  ngOnInit(): void {
    this.courseService.getCourses().subscribe({ next: (courses) => (this.availableCourses = courses.length) });
    console.log('HomeComponent initialised — courses loaded');
  }

  onEnrollClick(): void {
    this.message = 'Enrollment opened!';
  }

  ngOnDestroy(): void {
    console.log('HomeComponent destroyed');
  }
}
