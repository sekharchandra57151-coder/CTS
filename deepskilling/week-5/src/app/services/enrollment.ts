import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, forkJoin, map, switchMap } from 'rxjs';
import { Enrollment, Student } from '../models/enrollment.model';

@Injectable({
  providedIn: 'root',
})
export class EnrollmentService {
  private readonly apiUrl = 'http://localhost:3000';

  constructor(private readonly http: HttpClient) {}

  createStudent(student: Omit<Student, 'id'>): Observable<Student> {
    return this.http.post<Student>(`${this.apiUrl}/students`, student);
  }

  enroll(enrollment: Omit<Enrollment, 'id'>): Observable<Enrollment> {
    return this.http.post<Enrollment>(`${this.apiUrl}/enrollments`, enrollment);
  }

  getEnrollments(): Observable<Enrollment[]> {
    return this.http.get<Enrollment[]>(`${this.apiUrl}/enrollments`);
  }

  getStudentsByCourse(courseId: number): Observable<Student[]> {
    return this.http.get<Enrollment[]>(`${this.apiUrl}/enrollments?courseId=${courseId}`).pipe(
      switchMap((enrollments) =>
        enrollments.length
          ? forkJoin(enrollments.map((enrollment) => this.http.get<Student>(`${this.apiUrl}/students/${enrollment.studentId}`)))
          : [ [] ],
      ),
      map((students) => students as Student[]),
    );
  }
}
