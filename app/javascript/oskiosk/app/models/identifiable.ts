import { Exclude, Expose, Type } from "class-transformer";

import { Identifier } from "./identifier";

@Exclude()
export abstract class Identifiable{
    @Expose() @Type(() => Identifier) identifiers: Identifier[];

    addIdentifier(identifier: Identifier){
        this.identifiers.push(identifier);
    }

    deleteIdentifier(identifier: Identifier){
        let index = this.identifiers.indexOf(identifier, 0);
        if (index > -1) {
            this.identifiers.splice(index, 1);
        }
    }
}