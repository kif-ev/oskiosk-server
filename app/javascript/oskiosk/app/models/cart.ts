import { Exclude, Expose, Type } from "class-transformer";

import { CartItem } from "./cart-item";
import { Pricing } from "./pricing";

@Exclude()
export class Cart{
    @Expose() id: number;
    @Expose() @Type(() => CartItem) cart_items: CartItem[];
    @Expose() user_id: number;
    @Expose() lock_version: number;

    constructor(){
        this.cart_items = [];
    }

    isEmpty(): boolean {
        return this.cart_items.length == 0;
    }

    totalSum(): number {
        let sum = 0;
        for(let item of this.cart_items){
            sum += item.totalPrice();
        }
        return sum;
    }

    addToCart(product_name: string, pricing: Pricing, quantity: number = 1): void {
        for(let item of this.cart_items){
            if(item.pricing_id == pricing.id){
                item.quantity += quantity;
                return;
            }
        }
        this.cart_items.push(new CartItem(product_name, pricing.id, quantity, pricing.price));
    }

     private modifyQuantity(pricing_id: number, quantity: number): void {
        for(let item of this.cart_items){
            if(item.pricing_id == pricing_id){
                item.quantity += quantity;
                if(item.quantity <= 0){
                    this.cart_items.splice(this.cart_items.indexOf(item),1);
                }
                return;
            }
        }
    }

    increaseQuantity(pricing_id: number, quantity: number = 1){
        this.modifyQuantity(pricing_id, quantity)
    }

    decreaseQuantity(pricing_id: number, quantity: number = 1){
        this.modifyQuantity(pricing_id, -quantity)
    }
}