import { Exclude, Expose } from "class-transformer";

@Exclude()
export class Transaction{
    @Expose() id: number;
    @Expose() user_id: number;
    @Expose() user_name: string;
    @Expose() amount: number;
    @Expose() created_at: Date;

    constructor(id: number, user_id: number, user_name: string, amount: number, created_at: Date = new Date()) {
        this.id = id;
        this.user_id = user_id;
        this.user_name = user_name;
        this.amount = amount;
        this.created_at = created_at;
    }
}