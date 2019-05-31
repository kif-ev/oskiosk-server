import { Component, OnInit } from "@angular/core";
import { AngularTokenService } from "angular-token";
import { Router } from "@angular/router";
import { FlashMessageService } from "../services";

@Component({
    selector: 'login',
    template: require('../templates/login.html'),
    providers: []
})
export class LoginComponent implements OnInit{

    private user: string;
    private password: string;

    constructor(
        private tokenService: AngularTokenService,
        private flashMessageService: FlashMessageService,
        private router: Router
    ) { }

    loginUser(): void {
        this.tokenService.signIn({
            login:    this.user,
            password: this.password,
            userType: 'ADMIN'
        }).subscribe(
            res => {
                console.log(res);
                this.flashMessageService.flash('Logged in!', 'alert-success');
                this.router.navigate(['/'])
            },
            error => {
                console.log(error);
                this.flashMessageService.flash('Login failed!', 'alert-danger');
            }
        );
    }

    ngOnInit(): void {
        if(this.tokenService.userSignedIn()){
            this.router.navigate(['/'])
        }
    }
}