import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class LoadingService {
  private pendingRequests = 0;
  readonly isLoading$ = new BehaviorSubject(false);

  begin(): void {
    this.pendingRequests++;
    this.isLoading$.next(true);
  }

  end(): void {
    this.pendingRequests = Math.max(0, this.pendingRequests - 1);
    this.isLoading$.next(this.pendingRequests > 0);
  }
}
