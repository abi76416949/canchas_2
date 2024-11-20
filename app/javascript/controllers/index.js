// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)


import MercadoPagoController from "./mercado_pago_controller";

application.register("mercado-pago", MercadoPagoController);