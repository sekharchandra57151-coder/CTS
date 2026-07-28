import { createFeatureSelector, createSelector } from '@ngrx/store';
import { selectAllCourses } from '../course/course.selectors';
import { EnrollmentState } from './enrollment.reducer';

export const selectEnrollmentState = createFeatureSelector<EnrollmentState>('enrollment');
export const selectEnrolledIds = createSelector(selectEnrollmentState, (state) => state.enrolledCourseIds);
export const selectIsCourseEnrolled = (courseId: number) => createSelector(selectEnrolledIds, (ids) => ids.includes(courseId));
export const selectEnrolledCourses = createSelector(selectAllCourses, selectEnrolledIds, (courses, ids) => courses.filter((course) => ids.includes(course.id)));
