package com.example.proyecto_withe_power


import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
    private val REQUEST_CODE = 1;
    private val CHANNEL = "futprojs.com/mercadoPago"
/*
    fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
       // configureFlutterEngine(flutterEngine = FlutterEngine(this));
       // FlutterLoader().startInitialization(this)

    }


    private fun initFlutterChannels() {
      //  val channelMercadoPago = MethodChannel(flutterEngine, "futprojs.com/mercadoPago")

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { methodCall, result ->
            val args = methodCall.arguments as HashMap<String, Any>;
            val publicKey = args["publicKey"] as String
            val preferenceId = args["preferenceId"] as String;

            when(methodCall.method) {
                "mercadoPago" -> mercadoPago(publicKey, preferenceId, result)
                else -> return@setMethodCallHandler
            }
        }

    }

    private fun mercadoPago(publicKey: String, preferenceId: String, channelResult: MethodChannel.Result) {
        val checkout: MercadoPagoCheckout = MercadoPagoCheckout.Builder("public_key", "checkout_preference_id")
            .build()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val channelMercadoPagoRespuesta = MethodChannel(flutterView, "futprojs.com/mercadoPagoRespuesta")
        if(resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE) {
            val payment = data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT) as Payment
            val paymentStatus = payment.paymentStatus
            val paymentStatusDetails = payment.paymentStatusDetail
            val paymentID = payment.id

            val arrayList = ArrayList<String>()
            arrayList.add(paymentID.toString())
            arrayList.add(paymentStatus)
            arrayList.add(paymentStatusDetails)

            channelMercadoPagoRespuesta.invokeMethod("mercadoPagoOK", arrayList)
        } else if (resultCode == Activity.RESULT_CANCELED) {
            val arrayList = ArrayList<String>()
            arrayList.add("pagoError")
            channelMercadoPagoRespuesta.invokeMethod("mercadoPagoError", arrayList)
        } else {
            val arrayList = ArrayList<String>()
            arrayList.add("pagoCancelado")
            channelMercadoPagoRespuesta.invokeMethod("mercadoPagoError", arrayList)
        }
    }



 */
}

