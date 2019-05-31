import { Exclude, Expose } from "class-transformer";

@Exclude()
export class CartItem {
    @Expose({ toClassOnly: true }) product_name: string;
    @Expose() pricing_id: number;
    @Expose() quantity: number;
    @Expose({ toClassOnly: true }) unit_price: number;

    constructor(product_name: string, pricing_id: number, quantity: number, unit_price: number){
        this.product_name = product_name;
        this.pricing_id = pricing_id;
        this.quantity = quantity;
        this.unit_price = unit_price;
    }

    totalPrice(): number {
        return this.quantity * this.unit_price;
    }
}