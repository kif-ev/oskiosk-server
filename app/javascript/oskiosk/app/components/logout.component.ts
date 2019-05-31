import { Component, OnInit } from "@angular/core";
import { AngularTokenService } from "angular-token";
import { Router } from "@angular/router";
import { FlashMessageService } from "../services";

@Component({
    selector: 'logout',
    providers: [],
    template: ''
})
export class LogoutComponent implements OnInit{

    constructor(
        private tokenService: AngularTokenService,
        private flashMessageService: FlashMessageService,
        private router: Router
    ) { }

    logout(): void {
        this.tokenService.signOut().subscribe(
            res => {
                console.log(res);
                this.flashMessageService.flash('Logged out!', 'alert-success');
                this.router.navigate(['/']);
            },
            error => {
                console.log(error);
                this.flashMessageService.flash('Logout failed!', 'alert-danger');
            }
          );
    }

    ngOnInit(): void {
        if(this.tokenService.userSignedIn()){
            this.logout();
        }
    }
}