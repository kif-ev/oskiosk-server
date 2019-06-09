import { Injectable } from "@angular/core";
import { HttpClient, HttpHeaders } from "@angular/common/http";
import { deserialize, deserializeArray, serialize, plainToClass, classToPlain } from "class-transformer";

import { Observable, BehaviorSubject } from "rxjs";
import { map, finalize, catchError } from "rxjs/operators";

import { AngularTokenService } from "angular-token";

import { Product, User, Identifiable, Cart, PaymentTransaction, Transaction, Admin } from "../models";


@Injectable()
export class BackendService{

    private activeRequestCount: number = 0;
    private requestActive: BehaviorSubject<boolean> = new BehaviorSubject(false);
    
    constructor(
        private http: HttpClient,
        private tokenService: AngularTokenService
    ){
        
    }

    private onRequestStart() {
        this.activeRequestCount++;
        this.requestActive.next(true);
    }

    private onRequestEnd() {
        this.activeRequestCount--;
        if(this.activeRequestCount == 0) {
            this.requestActive.next(false);
        }
    }

    private httpGet(url: string): Observable<Object> {
        this.onRequestStart();
        return this.http.get(url, {responseType: "json"})
            .pipe(
                finalize(() => this.onRequestEnd())
            );
    }

    private httpPost(url: string, data: Object): Observable<Object> {
        this.onRequestStart();
        return this.http.post(url, data, {responseType: "json", headers: new HttpHeaders({ 'Content-Type': 'application/json' })})
            .pipe(
                finalize(() => this.onRequestEnd())
            );
    }

    private httpPatch(url: string, data: Object): Observable<Object> {
        this.onRequestStart();
        return this.http.patch(url, data, {responseType: "json", headers: new HttpHeaders({ 'Content-Type': 'application/json' })})
            .pipe(
                finalize(() => this.onRequestEnd())
            );
    }

    private httpDelete(url: string): Observable<Object> {
        this.onRequestStart();
        return this.http.delete(url, {responseType: "json", headers: new HttpHeaders({ 'Content-Type': 'application/json' })})
            .pipe(
                finalize(() => this.onRequestEnd())
            );
    }

    private handleError (error: Response | any) {
        console.log(error);
        return Observable.throw('Error!');
    }

    getRequestActive(): BehaviorSubject<boolean> {
        return this.requestActive;
    }

    
    /************************************************************
     *  Products
     ***********************************************************/

    getProducts(): Observable<Product[]> {
        return this.httpGet('/products.json')
        .pipe(
            map((products: Object[]) => { return plainToClass(Product, products); }),
            catchError(this.handleError)
        );
    }
    
    getProduct(id: number): Observable<Product> {
        return this.httpGet('/products/' + id + '.json')
        .pipe(
            map((product: Object) => { return plainToClass(Product, product); }),
            catchError(this.handleError)
        );
    }

    deleteProduct(product: Product): Observable<Object> {
        return this.httpDelete('/products/' + product.id + '.json');
    }

    private patchProduct(product: Product): Observable<Object> {
        return this.httpPatch('/products/' + product.id + '.json', classToPlain(product));
    }

    private postProduct(product: Product): Observable<Object> {
        return this.httpPost('/products', classToPlain(product));
    }

    saveProduct(product: Product): Observable<Product> {
        let observable: Observable<Object>;
        if(product.id){
            observable = this.patchProduct(product);
        }
        else {
            observable = this.postProduct(product);
        }
        return observable
        .pipe(
            map((product: Object) => { return plainToClass(Product, product); }),
            catchError(this.handleError)
        );
    }

    /************************************************************
     *  Users
     ***********************************************************/
    
    getUsers(): Observable<User[]> {
        return this.httpGet('/users.json')
        .pipe(
            map((users: Object[]) => { return plainToClass(User, users); }),
            catchError(this.handleError)
        );
    }
    
    getUser(id: number): Observable<User> {
        return this.httpGet('/users/' + id + '.json')
        .pipe(
            map((user: Object) => { return plainToClass(User, user); }),
            catchError(this.handleError)
        );
    }

    deleteUser(user: User): Observable<Object> {
        return this.httpDelete('/users/' + user.id + '.json');
    }

    private patchUser(user: User): Observable<Object> {
        return this.httpPatch('/users/' + user.id + '.json', classToPlain(user));
    }

    private postUser(user: User): Observable<Object> {
        return this.httpPost('/users', classToPlain(user));
    }

    saveUser(user: User): Observable<User> {
        let observable: Observable<Object>;
        if(user.id){
            observable = this.patchUser(user);
        }
        else {
            observable = this.postUser(user);
        }
        return observable
        .pipe(
            map((user: Object) => { return plainToClass(User, user); }),
            catchError(this.handleError)
        );
    }

    /************************************************************
     *  Admins
     ***********************************************************/
    
    getAdmins(): Observable<Admin[]> {
        return this.httpGet('/admins.json')
        .pipe(
            map((admins: Object[]) => { return plainToClass(Admin, admins); }),
            catchError(this.handleError)
        );
    }
    
    getAdmin(id: number): Observable<Admin> {
        return this.httpGet('/admins/' + id + '.json')
        .pipe(
            map((admin: Object) => { return plainToClass(Admin, admin); }),
            catchError(this.handleError)
        );
    }

    deleteAdmin(admin: Admin): Observable<Object> {
        return this.httpDelete('/admins/' + admin.id + '.json');
    }

    private patchAdmin(admin: Admin): Observable<Object> {
        return this.httpPatch('/admins/' + admin.id + '.json', classToPlain(admin));
    }

    private postAdmin(admin: Admin): Observable<Object> {
        return this.httpPost('/admins', classToPlain(admin));
    }

    saveAdmin(admin: Admin): Observable<Admin> {
        let observable: Observable<Object>;
        if(admin.id){
            observable = this.patchAdmin(admin);
        }
        else {
            observable = this.postAdmin(admin);
        }
        return observable
        .pipe(
            map((admin: Object) => { return plainToClass(Admin, admin); }),
            catchError(this.handleError)
        );
    }

    /************************************************************
     *  Identifiers
     ***********************************************************/

    private handleIdentifierResponse(res: Object) {
        if(res['type'] == 'user'){
            return plainToClass(User, res);
        }
        else if(res['type'] == 'product'){
            return plainToClass(Product, res);
        }
    }
    
    getItemByIdentifier(identifier: string): Observable<Identifiable> {
        return this.httpGet('/identifiers/' + identifier + '.json')
        .pipe(
            map(this.handleIdentifierResponse),
            catchError(this.handleError)
        );
    }

    /************************************************************
     *  Carts and Transactions
     ***********************************************************/
    
    payCart(cart: Cart): Observable<PaymentTransaction> {
        return this.httpPost('/carts/' + cart.id + '/pay.json', {'lock_version': cart.lock_version})
        .pipe(
            map((paymentTransaction: Object) => { return plainToClass(PaymentTransaction, paymentTransaction); }),
            catchError(this.handleError)
        );
    }

    createOrUpdateCart(cart: Cart): Observable<Cart> {
        let observable: Observable<Object>;
        if(cart.id){
            observable = this.httpPatch('/carts/' + cart.id + '.json', classToPlain(cart))
        }
        else {
            observable = this.httpPost('/carts.json', classToPlain(cart))
        }
        return observable
        .pipe(
            map((cart: Object) => { return plainToClass(Cart, cart); }),
            catchError(this.handleError)
        );
    }

    deposit(user: User, amount: number): Observable<Transaction> {
        return this.httpPost('/users/' + user.id + '/deposit.json', {'amount': amount})
        .pipe(
            map((transaction: Object) => { return plainToClass(Transaction, transaction); }),
            catchError(this.handleError)
        );
    }
}
