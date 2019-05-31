import { Component } from "@angular/core";
import { AngularTokenService } from "angular-token";

@Component({
    selector: 'navbar',
    template: require('../templates/navbar.html'),
    providers: []
})
export class NavbarComponent{

    constructor(
        private tokenService: AngularTokenService
    ) { }

    items = []; // ToDo: Dynamically populate the navbar
}