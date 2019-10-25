import { Component, OnInit } from "@angular/core";
import { User } from "../models";
import { BackendService, FlashMessageService } from "../services";

@Component({
    selector: 'user-list',
    template: require('../templates/user-list.html'),
    providers: []
})
export class UserListComponent implements OnInit{
    users: User[];
    filteredUsers: User[];
    _filter: string = '';

    get filter(): string {
        return this._filter;
    }

    set filter(value: string) {
        this._filter = value;
        this.filterUsers();
    }

    constructor(
        private backendService: BackendService,
        private flashMessageService: FlashMessageService
    ) { }

    filterUsers(): void {
        this.filteredUsers = [];

        for(let user of this.users) {
            if(user.name && user.name.toLowerCase().includes(this._filter.toLowerCase())) {
                this.filteredUsers.push(user);
                continue;
            }
            for(let identifier of user.identifiers){
                if(identifier.code.toLowerCase().includes(this._filter.toLowerCase())){
                    this.filteredUsers.push(user);
                    continue;
                }
            }
        }
    }

    deleteUser(user): void {
        if(!confirm("Are you sure you want to delete user " + user.name + "? This can not be undone!"))
            return;
        this.backendService.deleteUser(user)
            .subscribe(
                response => {
                    this.flashMessageService.flash('User deleted.', 'alert-success');
                    this.getUsers();
                },
                error => {
                    this.flashMessageService.flash('Failed to delete user!', 'alert-danger')
                }
            );
    }

    getUsers(): void {
        this.backendService.getUsers().subscribe(users => { this.users = users; this.filterUsers(); });
    }

    ngOnInit(): void {
        this.getUsers();
    }
}