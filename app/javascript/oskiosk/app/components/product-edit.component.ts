import { Component, OnInit } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";

import { Product, Identifier, Pricing, Tag } from "../models";
import { BackendService, FlashMessageService } from "../services";

@Component({
    selector: 'product-edit',
    template: require('../templates/product-edit.html'),
    providers: []
})
export class ProductEditComponent implements OnInit {

    private product: Product;

    constructor(
        private backend_service: BackendService,
        private flash_message_service: FlashMessageService,
        private route: ActivatedRoute,
        private router: Router
    ) { }

    addTag(): void {
        this.product.addTag(new Tag(''));
    }

    deleteTag(tag: Tag): void {
        this.product.deleteTag(tag);
    }

    addIdentifier(): void {
        this.product.addIdentifier(new Identifier(''));
    }

    deleteIdentifier(identifier: Identifier): void {
        this.product.deleteIdentifier(identifier);
    }

    addPricing(): void {
        this.product.addPricing(new Pricing(null, 0, 999999));
    }

    deletePricing(pricing: Pricing): void {
        this.product.deletePricing(pricing);
    }

    ngOnInit(): void {
        this.product = new Product(null, null);
        this.route
        .params
        .subscribe(paramMap => {
            let product_id = paramMap['id'];
            if(product_id){
                this.backend_service.getProduct(+product_id)
                .subscribe(
                    product => this.product = product,
                    error => this.flash_message_service.flash('Failed to load product!', 'alert-danger')
                );
            }
        });
    }

    save(): void {
        this.backend_service.saveProduct(this.product)
        .subscribe(
            product => {
                this.flash_message_service.flash('Product saved!', 'alert-success');
                this.router.navigate(['/products']);
            },
            error => {
                this.flash_message_service.flash('Failed to save product!', 'alert-danger');
            }
        );
    }
}
