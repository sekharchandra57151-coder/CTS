import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { EnrollmentService } from '../../services/enrollment';
import { switchMap } from 'rxjs';

@Component({
  selector: 'app-enrollment-form',
  imports: [CommonModule, FormsModule],
  templateUrl: './enrollment-form.html',
  styleUrl: './enrollment-form.css',
})
export class EnrollmentForm {
  studentName = '';
  studentEmail = '';
  courseId: number | null = null;
  preferredSemester = '';
  agreeToTerms = false;
  submitted = false;
  errorMessage = '';

  constructor(private readonly enrollmentService: EnrollmentService) {}

  onSubmit(form: NgForm): void {
    if (form.invalid) {
      return;
    }

    this.errorMessage = '';
    this.enrollmentService
      .createStudent({ name: this.studentName, email: this.studentEmail })
      .pipe(
        switchMap((student) =>
          this.enrollmentService.enroll({
            studentId: student.id,
            courseId: this.courseId!,
            preferredSemester: this.preferredSemester,
          }),
        ),
      )
      .subscribe({
        next: () => (this.submitted = true),
        error: (error) => (this.errorMessage = error.message || 'Could not submit enrollment.'),
      });
  }

  resetForm(form: NgForm): void {
    form.resetForm();
    this.submitted = false;
  }
}
