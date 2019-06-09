import { Expose, Exclude } from "class-transformer";

@Exclude()
export class Admin {
    @Expose() id: number;
    @Expose() email: string;
    @Expose({ toPlainOnly: true }) password: string;

    constructor(id: number, email: string){
        this.id = id;
        this.email = email;
    }
}
