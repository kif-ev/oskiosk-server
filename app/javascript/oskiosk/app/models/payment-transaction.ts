import { Exclude, Expose, Type } from "class-transformer";

import { Transaction } from "./transaction";
import { TransactionItem } from "./transaction-item";

@Exclude()
export class PaymentTransaction extends Transaction {
    @Expose() @Type(() => TransactionItem) transaction_items: TransactionItem[];

    constructor(id: number, user_id: number, user_name: string, amount: number, created_at: Date = new Date(), transaction_items: TransactionItem[] = []) {
        super(id, user_id, user_name, amount, created_at);
        this.transaction_items = transaction_items;
    }
}