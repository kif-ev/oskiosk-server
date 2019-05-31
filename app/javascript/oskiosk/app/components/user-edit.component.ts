import { Component, OnInit } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";

import { User, Tag, Identifier } from "../models";
import { BackendService, FlashMessageService } from "../services";

@Component({
    selector: 'user-edit',
    template: require('../templates/user-edit.html'),
    providers: []
})
export class UserEditComponent implements OnInit {

    private user: User;

    constructor(
        private backend_service: BackendService,
        private flashMessageService: FlashMessageService,
        private route: ActivatedRoute,
        private router: Router
    ) { }

    addTag(): void {
        this.user.addTag(new Tag(''));
    }

    deleteTag(tag: Tag): void {
        this.user.deleteTag(tag);
    }

    addIdentifier(): void {
        this.user.addIdentifier(new Identifier(''));
    }

    deleteIdentifier(identifier: Identifier): void {
        this.user.deleteIdentifier(identifier);
    }

    ngOnInit(): void {
        this.user = new User(null, null);
        this.route
        .params
        .subscribe(paramMap => {
            let user_id = paramMap['id'];
            if(user_id){
                this.backend_service.getUser(+user_id)
                .subscribe(
                    user => this.user = user,
                    error => this.flashMessageService.flash('Failed to load user!', 'alert-danger')
                );
            }
        });
    }

    save(): void {
        this.backend_service.saveUser(this.user)
        .subscribe(
            user => {
                this.flashMessageService.flash('User saved!', 'alert-success');
                this.router.navigate(['/users']);
            },
            error => {
                this.flashMessageService.flash('Failed to save user!', 'alert-danger');
            }
        );
    }
}
