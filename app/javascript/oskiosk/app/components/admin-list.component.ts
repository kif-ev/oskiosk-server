import { Component, OnInit } from "@angular/core";
import { Admin } from "../models";
import { BackendService, FlashMessageService } from "../services";

@Component({
    selector: 'admin-list',
    template: require('../templates/admin-list.html'),
    providers: []
})
export class AdminListComponent implements OnInit{
    admins: Admin[];
    filteredAdmins: Admin[];
    _filter: string = '';

    get filter(): string {
        return this._filter;
    }

    set filter(value: string) {
        this._filter = value;
        this.filterAdmins();
    }

    constructor(
        private backendService: BackendService,
        private flashMessageService: FlashMessageService
    ) { }

    filterAdmins(): void {
        this.filteredAdmins = [];

        for(let admin of this.admins) {
            if(admin.email && admin.email.toLowerCase().includes(this._filter.toLowerCase())) {
                this.filteredAdmins.push(admin);
                continue;
            }
        }
    }

    deleteAdmin(admin): void {
        if(!confirm("Are you sure you want to delete admin " + admin.email + "? This can not be undone!"))
            return;
        this.backendService.deleteAdmin(admin)
            .subscribe(
                response => {
                    this.flashMessageService.flash('Admin deleted.', 'alert-success');
                    this.getAdmins();
                },
                error => {
                    this.flashMessageService.flash('Failed to delete admin!', 'alert-danger')
                }
            );
    }

    getAdmins(): void {
        this.backendService.getAdmins().subscribe(admins => { this.admins = admins; this.filterAdmins(); });
    }

    ngOnInit(): void {
        this.getAdmins();
    }
}