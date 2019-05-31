import { Exclude, Expose, Type, Transform } from "class-transformer";

import { Pricing} from "./pricing";
import { Identifier } from "./identifier";
import { Identifiable } from "./identifiable";
import { Tag } from "./tag"

@Exclude()
export class Product extends Identifiable {
    @Expose() id: number;
    @Expose() name: string;
    @Expose() @Type(() => Tag) tags: Tag[];
    @Expose() @Type(() => Pricing) pricings: Pricing[];

    constructor(id: number, name: string, tags: Tag[] = [], identifiers: Identifier[] = [], pricings: Pricing[] = []){
        super();
        this.id = id;
        this.name = name;
        this.tags = tags;
        this.identifiers = identifiers;
        this.pricings = pricings;
    }

    addPricing(pricing: Pricing){
        this.pricings.push(pricing);
    }

    deletePricing(pricing: Pricing){
        let index = this.pricings.indexOf(pricing, 0);
        if (index > -1) {
            this.pricings.splice(index, 1);
        }
    }

    addTag(tag: Tag){
        this.tags.push(tag);
    }

    deleteTag(tag: Tag){
        let index = this.tags.indexOf(tag, 0);
        if (index > -1) {
            this.tags.splice(index, 1);
        }
    }
}