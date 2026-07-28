import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Course } from '../models/course.model';
import { Observable, throwError } from 'rxjs';
import { catchError, map, retry, tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class CourseService {
  private readonly apiUrl = 'http://localhost:3000/courses';

  constructor(private readonly http: HttpClient) {}

  getCourses(): Observable<Course[]> {
    return this.http.get<Course[]>(this.apiUrl).pipe(
      // map transforms response data; tap is reserved for non-mutating side effects such as logging.
      map((courses) => courses.filter((course) => course.credits > 0)),
      tap((courses) => console.log('Courses loaded:', courses.length)),
      retry(2),
      catchError((error) => {
        console.error('Unable to load courses', error);
        return throwError(() => new Error('Failed to load courses. Please try again.'));
      }),
    );
  }

  getCourseById(id: number): Observable<Course> {
    return this.http.get<Course>(`${this.apiUrl}/${id}`);
  }

  createCourse(course: Omit<Course, 'id'>): Observable<Course> {
    return this.http.post<Course>(this.apiUrl, course);
  }

  updateCourse(course: Course): Observable<Course> {
    return this.http.put<Course>(`${this.apiUrl}/${course.id}`, course);
  }

  deleteCourse(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }
}
