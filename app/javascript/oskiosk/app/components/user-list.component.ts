import { Component, OnInit } from "@angular/core";
import { User } from "../models";
import { BackendService } from "../services/backend.service";

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

    constructor(private backendService: BackendService) { }

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

    getUsers(): void {
        this.backendService.getUsers().subscribe(users => { this.users = users; this.filterUsers(); });
    }

    ngOnInit(): void {
        this.getUsers();
    }
}