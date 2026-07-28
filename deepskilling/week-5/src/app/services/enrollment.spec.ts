import { TestBed } from '@angular/core/testing';

import { EnrollmentService } from './enrollment';
import { provideHttpClient } from '@angular/common/http';

describe('EnrollmentService', () => {
  let service: EnrollmentService;

  beforeEach(() => {
    TestBed.configureTestingModule({ providers: [provideHttpClient()] });
    service = TestBed.inject(EnrollmentService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
