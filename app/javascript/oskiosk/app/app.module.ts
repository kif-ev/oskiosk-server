import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterModule }   from '@angular/router';
import { HttpClientModule } from '@angular/common/http'

import { AngularTokenModule } from 'angular-token';

import { AppComponent } from './app.component';

import { 
  ProductListComponent,
  ProductEditComponent,
  ProductImportComponent,
  UserListComponent,
  UserEditComponent,
  UserImportComponent,
  SalesPointComponent,
  CashPointComponent,
  SelfServicePointComponent,
  NavbarComponent,
  FlashMessageComponent,
  WaitIndicatorComponent,
  HomeComponent,
  LoginComponent,
  LogoutComponent
} from "./components";
import { FlashMessageService, BackendService } from "./services";


@NgModule({
  declarations: [
    AppComponent,
    ProductEditComponent,
    ProductListComponent,
    ProductImportComponent,
    UserEditComponent,
    UserListComponent,
    UserImportComponent,
    SalesPointComponent,
    CashPointComponent,
    SelfServicePointComponent,
    NavbarComponent,
    FlashMessageComponent,
    WaitIndicatorComponent,
    HomeComponent,
    LoginComponent,
    LogoutComponent
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
