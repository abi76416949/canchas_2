import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Controlador de Yape conectado.");

    window.handleYape = async () => {
      const otp = document.getElementById("form-checkout__payerOTP").value;
      const phoneNumber = document.getElementById("form-checkout__payerPhone").value;
      const email = document.getElementById("form-checkout__email").value;

      try {


        console.log("OTP:", otp);
        console.log("Phone number:", phoneNumber);
        // Enviar datos al backend para procesar el pago
        const response = await fetch(`/reservas/create_payment`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
          },
          body: JSON.stringify({
            phoneNumber: phoneNumber,
            otp: otp,
            payer: {
              email: email,
            },
          }),
        });

        const result = await response.json();
        if (result.status === "approved") {
          alert("Pago aprobado y reserva confirmada.");
          window.location.href = "/polideportivos/${polideportivoId}/canchas/${canchaId}/reservas/create_payment"; // Cambiar según la ruta final
        } else {
          alert(result.message || "Error al procesar el pago. Intente nuevamente.");
        }
      } catch (error) {
        console.error("Error al procesar Yape:", error);
        alert("Hubo un problema al procesar Yape. Intente nuevamente.");
      }
    };
  }
}
