import { Exclude, Expose } from "class-transformer";

@Exclude()
export class Identifier {
    @Expose() code: string;

    constructor(code: string) {
        this.code = code;
    }
}