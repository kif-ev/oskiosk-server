import { Component, OnInit } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";

import { Admin } from "../models";
import { BackendService, FlashMessageService } from "../services";

@Component({
    selector: 'admin-edit',
    template: require('../templates/admin-edit.html'),
    providers: []
})
export class AdminEditComponent implements OnInit {

    private admin: Admin;

    constructor(
        private backend_service: BackendService,
        private flashMessageService: FlashMessageService,
        private route: ActivatedRoute,
        private router: Router
    ) { }

    ngOnInit(): void {
        this.admin = new Admin(null, null);
        this.route
        .params
        .subscribe(paramMap => {
            let admin_id = paramMap['id'];
            if(admin_id){
                this.backend_service.getAdmin(+admin_id)
                .subscribe(
                    admin => this.admin = admin,
                    error => this.flashMessageService.flash('Failed to load admin!', 'alert-danger')
                );
            }
        });
    }

    save(): void {
        this.backend_service.saveAdmin(this.admin)
        .subscribe(
            user => {
                this.flashMessageService.flash('Admin saved!', 'alert-success');
                this.router.navigate(['/admins']);
            },
            error => {
                this.flashMessageService.flash('Failed to save admin!', 'alert-danger');
            }
        );
    }
}
