import { Expose, Exclude } from "class-transformer";

@Exclude()
export class TransactionItem {
    @Expose() id: number;
    @Expose() product_id: number;
    @Expose() name: string;
    @Expose() quantity: number;
    @Expose() price: number;

    constructor(id: number, product_id: number, name: string, quantity: number, price: number){
        this.id = id;
        this.product_id = product_id;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
    }
}