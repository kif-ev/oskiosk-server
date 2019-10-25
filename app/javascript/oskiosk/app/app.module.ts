import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterModule }   from '@angular/router';
import { HttpClientModule } from '@angular/common/http'

import { AngularTokenModule } from 'angular-token';

import { AppComponent } from './app.component';

import {
  AdminEditComponent,
  AdminListComponent,
  CashPointComponent,
  HomeComponent,
  FlashMessageComponent,
  LoginComponent,
  LogoutComponent,
  NavbarComponent,
  ProductEditComponent,
  ProductImportComponent,
  ProductListComponent,
  SalesPointComponent,
  SelfServicePointComponent,
  UserEditComponent,
  UserImportComponent,
  UserListComponent,
  WaitIndicatorComponent
} from "./components";
import { FlashMessageService, BackendService } from "./services";


@NgModule({
  declarations: [
    AppComponent,
    AdminEditComponent,
    AdminListComponent,
    CashPointComponent,
    FlashMessageComponent,
    HomeComponent,
    LoginComponent,
    LogoutComponent,
    NavbarComponent,
    ProductEditComponent,
    ProductImportComponent,
    ProductListComponent,
    SalesPointComponent,
    SelfServicePointComponent,
    UserEditComponent,
    UserImportComponent,
    UserListComponent,
    WaitIndicatorComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    AngularTokenModule.forRoot({
      userTypes: [
        { name: 'ADMIN', path: 'admin' }
      ]
    }),
    RouterModule.forRoot([
      {
        path: 'products',
        component: ProductListComponent
      },
      {
        path: 'product/new',
        component: ProductEditComponent
      },
      {
        path: 'product/import',
        component: ProductImportComponent
      },
      {
        path: 'product/:id',
        component: ProductEditComponent
      },
      {
        path: 'users',
        component: UserListComponent
      },
      {
        path: 'user/new',
        component: UserEditComponent
      },
      {
        path: 'user/import',
        component: UserImportComponent
      },
      {
        path: 'user/:id',
        component: UserEditComponent
      },
      {
        path: 'admins',
        component: AdminListComponent
      },
      {
        path: 'admin/new',
        component: AdminEditComponent
      },
      {
        path: 'admin/:id',
        component: AdminEditComponent
      },
      {
        path: 'sales-point',
        component: SalesPointComponent
      },
      {
        path: 'cash-point',
        component: CashPointComponent
      },
      {
        path: 'self-service-point',
        component: SelfServicePointComponent
      },
      {
        path: 'login',
        component: LoginComponent
      },
      {
        path: 'logout',
        component: LogoutComponent
      },
      {
        path: '**',
        component: HomeComponent
      }
    ])
  ],
  providers: [AngularTokenModule, BackendService, FlashMessageService],
  bootstrap: [AppComponent]
})
export class AppModule {}
