import { Component } from '@angular/core';
import { NotificationService } from '../../services/notification';

@Component({
  selector: 'app-notification',
  imports: [],
  // This provider creates a separate NotificationService instance for this component and its children.
  providers: [NotificationService],
  templateUrl: './notification.html',
  styleUrl: './notification.css',
})
export class Notification {
  constructor(readonly notificationService: NotificationService) {}
}
