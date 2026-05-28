#!/bin/bash

# ─── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'
RESET='\033[0m'

# ─── Skull ASCII Art ──────────────────────────────────────────────────────────
SKULL='                          ::x.
                    <!X!!!!HMM$$$$W.
               ---!H8MMH?M$$$$$$$$$8X.
              -<!!!MMM$$$$$$$$$$$$$$$$X!:           
            !----!!M?M$$$$$$$$$$$$$$$$MM!!<
          '"'"'<M!  !!!MMM$$$$$$$$$$$$$$$MMMX!X!
           !M!--!!!MMM$$$$$$$$$$$$$$$MMM!X$!    
           -!8!:!!!MMMMM$$$$$$$$$$$$RMMMX8RX-               
         <!-!$X!-!!!MHM$$$$$$$$$$$RMMMMMM$!!!
         !!:-MRX!-!!MM$$$$8$$$$$$$$$MMMM$R!-!       
        '"'"'!X:--?X!--!!!M$$$RMR$$$$RMMRMM$R!!!X!     
         -XX  '"'"'MX:!!!!!?RRMMMMM!!XMMMM$R-<!!!!   
          !?!-X$P"````----!M!!---`#*R$$M !<!!-     
          -!MXf        -!-!!!X!        "k!!!-              
          '"'"'!!!X         !X!M?X         '"'"'!!!-
          -<!XM         X!!R!!         !M!-'"'"'
          :!XMMX  : ::s@---!!!Mbx:!!<::X8k !       
         !!!$$$MTMM8$#!!   ! MXX!R$W86SW$$!!!     
          !!!M$$#TT!!!!!-  !  X!!!!!!RR#M!!!          
           `!MW$M- -!!M!!  !  !!:!-- #$R?!!
            -:..    -XM!k:!#hHMX!!-    ::-        
             -M!   <!!!$X?XMMMB$!!!   !!
              !X!  !XR!$MM$$$$$$?MM! '"'"'!!         
              `MX  '"'"'XXX t!@!H!X8X    '"'"'!>         
               !!X!!X!" MM$M$RR*?.!!:X!            
               ?&M<!X>!MR$M> M9M5M!!XMM                
                M!?XX!!RRt?M@NRX?!XMX!R             
                 `!!MHXX!!Mt!MMXWMM!!!            
                   `!XM$$$R9M$RTMMX-               
                     #$WXXW$$MXW$"              
                        `""!""`'

# ─── Typewriter print function ────────────────────────────────────────────────
typewriter() {
    while IFS= read -r line; do
        echo -e "${RED}${line}${RESET}"
        sleep 0.04
    done <<< "$1"
}

# ─── Wait for ollama server to be ready ──────────────────────────────────────
echo -e "${RED}  [ Waiting for ollama server... ]${RESET}"
for i in {1..30}; do
    if ollama list &>/dev/null 2>&1; then
        break
    fi
    sleep 1
done

# ─── Main ─────────────────────────────────────────────────────────────────────
clear
typewriter "$SKULL"
echo ""
echo -e "${RED}              [CHAT HISTORY IS DISABLED]${RESET}"
echo ""
sleep 0.5

OLLAMA_NOHISTORY=1 ollama run rebel
