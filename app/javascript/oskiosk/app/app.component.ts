import { Component, OnInit } from '@angular/core';
import { AngularTokenService } from 'angular-token';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  template: '<wait-indicator></wait-indicator><flash-messages></flash-messages><router-outlet></router-outlet>'
})
export class AppComponent implements OnInit {
  version = "1.0"

  constructor(
    private tokenService: AngularTokenService,
    private router: Router
) { }

  ngOnInit(): void {
    if(!this.tokenService.userSignedIn()){
      this.router.navigate(['/login']);
      return
    }
    this.tokenService.validateToken().subscribe(
      res => {
        console.log(res);
      },
      error => {
        console.log(error);
        this.router.navigate(['/login']);
      }
    );
}
}
