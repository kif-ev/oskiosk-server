import { Component, OnInit } from "@angular/core";
import { BackendService } from "../services"

@Component({
    selector: 'wait-indicator',
    template: require('../templates/wait-indicator.html'),
    providers: []
})
export class WaitIndicatorComponent implements OnInit{
    requestActive: boolean;

    constructor(private backendService: BackendService) {}

    ngOnInit() {
        this.backendService.getRequestActive().subscribe(value => this.requestActive = value);
    }
}
