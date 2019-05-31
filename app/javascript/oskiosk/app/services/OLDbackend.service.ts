import { Product, User, Identifiable, Cart, PaymentTransaction, Transaction } from "../models";
import { Observable, BehaviorSubject } from "rxjs";

export class BackendService{
    getProducts(): Observable<Product[]> {
        throw Error('Not implemented.');
    }
    
    getProduct(id: number): Observable<Product> {
        throw Error('Not implemented.');
    }
    
    getUsers(): Observable<User[]> {
        throw Error('Not implemented.');
    }
    
    getUser(id: number): Observable<User> {
        throw Error('Not implemented.');
    }
    
    getItemByIdentifier(identifier: string): Observable<Identifiable> {
        throw Error('Not implemented.');
    }
    
    payCart(cart: Cart): Observable<PaymentTransaction> {
        throw Error('Not implemented.');
    }

    saveProduct(product: Product): Observable<Product> {
        throw Error('Not implemented.');
    }

    saveUser(user: User): Observable<User> {
        throw Error('Not implemented.');
    }

    createOrUpdateCart(cart: Cart): Observable<Cart> {
        throw Error('Not implemented.');
    }

    deposit(user: User, amount: number): Observable<Transaction> {
        throw Error('Not implemented.');
    }

    getRequestActive(): BehaviorSubject<boolean> {
        throw Error('Not implemented.');
    }
}
