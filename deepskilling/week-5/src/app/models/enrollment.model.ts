export interface Student {
  id: number;
  name: string;
  email: string;
}

export interface Enrollment {
  id: number;
  studentId: number;
  courseId: number;
  preferredSemester: string;
}
