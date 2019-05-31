import { Injectable } from "@angular/core";

export class FlashMessage {
    messageText: string;
    messageClass: string;

    constructor(messageText: string, messageClass: string) {
        this.messageText = messageText;
        this.messageClass = messageClass;
    }
}

@Injectable()
export class FlashMessageService {
    static flashMessages:FlashMessage[] = [];

    getFlashMessages(): FlashMessage[] {
        return FlashMessageService.flashMessages;
    }

    removeMessage(message: FlashMessage){
        let index = FlashMessageService.flashMessages.indexOf(message);
        if(index > -1) {
            FlashMessageService.flashMessages.splice(index, 1);
        }
    }

    flash(messageText: string, messageClass: string) {
        let message = new FlashMessage(messageText, messageClass);
        FlashMessageService.flashMessages.push(message);
        setTimeout(() => { this.removeMessage(message); }, 5000);
    }
}
