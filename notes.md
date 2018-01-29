1. Should PIO bus be 32b ? Since it is an internal bus. In general for interfaces we would like to parameterize the address and bus width. How to do that ?
Demo: Why bother?


2. If we make the pio agent passive, then we should instantiate the predictor ? Missing currently.

3. Timing diagram for the pio bus.: PNG file. 

4. Initialize call in sequence. How to differ from member variables ? Sometmes it is not obvious which are input parameters and which are internal state ?
    Use local for internal state. Global for external.
But within external some are input and some are output ? No way except by comment.
