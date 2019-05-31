import { Component, OnInit } from "@angular/core";

import { BackendService } from "../services";
import { Product } from "../models";

@Component({
    selector: 'product-list',
    template: require('../templates/product-list.html'),
    providers: []
})
export class ProductListComponent implements OnInit{
    products: Product[];
    filteredProducts: Product[];
    private _filter: string = '';

    get filter(): string {
        return this._filter;
    }

    set filter(value: string) {
        this._filter = value;
        this.filterProducts();
    }

    filterProducts(): void {
        this.filteredProducts = [];

        for(let product of this.products) {
            if(product.name && product.name.toLowerCase().includes(this._filter.toLowerCase())) {
                this.filteredProducts.push(product);
                continue;
            }
            for(let identifier of product.identifiers){
                if(identifier.code.toLowerCase().includes(this._filter.toLowerCase())){
                    this.filteredProducts.push(product);
                    continue;
                }
            }
        }
    }

    constructor(private backendService: BackendService) { }

    getProducts(): void {
        this.backendService.getProducts().subscribe(products => {
            this.products = products;
            this.filterProducts();
        });
    }

    ngOnInit(): void {
        this.getProducts();
    }
}