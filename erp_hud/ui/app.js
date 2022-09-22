$(document).ready(() => {

    var forEach = function (array, callback, scope) {
        for (var i = 0; i < array.length; i++) {
            callback.call(scope, i, array[i]);
        }
    };

    setInterval(() => {
        let max = 2160;
        forEach(document.querySelectorAll(".health-hex"), function (index, value) {
            let percent = $(".health-hex").data("progress")
            value.querySelector(".fill").setAttribute(
                "style",
                "stroke-dashoffset: " + ((100 - percent) / 100) * max
            );
        });
        forEach(document.querySelectorAll(".armor-hex"), function (index, value) {
            let percent = $(".armor-hex").data("progress")
            value.querySelector(".fill").setAttribute(
                "style",
                "stroke-dashoffset: " + ((100 - percent) / 100) * max
            );
        });
        forEach(document.querySelectorAll(".hunger-hex"), function (index, value) {
            let percent = $(".hunger-hex").data("progress")
            value.querySelector(".fill").setAttribute(
                "style",
                "stroke-dashoffset: " + ((100 - percent) / 100) * max
            );
        });
        forEach(document.querySelectorAll(".thirst-hex"), function (index, value) {
            let percent = $(".thirst-hex").data("progress")
            value.querySelector(".fill").setAttribute(
                "style",
                "stroke-dashoffset: " + ((100 - percent) / 100) * max
            );
        });
        forEach(document.querySelectorAll(".stress-hex"), function (index, value) {
            let percent = $(".stress-hex").data("progress")
            value.querySelector(".fill").setAttribute(
                "style",
                "stroke-dashoffset: " + ((100 - percent) / 100) * max
            );
        });
        forEach(document.querySelectorAll(".oxygen-hex"), function (index, value) {
            let percent = $(".oxygen-hex").data("progress")
            value.querySelector(".fill").setAttribute(
                "style",
                "stroke-dashoffset: " + ((100 - percent) / 100) * max
            );
        });
    }, 1);

    $(".hud-options-position-holder").on("click", ".hud-options-tag", function () {
        if (this.id == "general-pos-1") {
            $("#general-pos-1").addClass("green-tag")
            $("#general-pos-1").removeClass("red-tag")
            $("#general-pos-2").removeClass("green-tag")
            $("#general-pos-3").removeClass("green-tag")
            $("#general-pos-4").removeClass("green-tag")
            $("#general-pos-2").addClass("red-tag")
            $("#general-pos-3").addClass("red-tag")
            $("#general-pos-4").addClass("red-tag")
        } else if (this.id == "general-pos-2") {
            $("#general-pos-2").addClass("green-tag")
            $("#general-pos-2").removeClass("red-tag")
            $("#general-pos-1").removeClass("green-tag")
            $("#general-pos-3").removeClass("green-tag")
            $("#general-pos-4").removeClass("green-tag")
            $("#general-pos-1").addClass("red-tag")
            $("#general-pos-3").addClass("red-tag")
            $("#general-pos-4").addClass("red-tag")
        } else if (this.id == "general-pos-3") {
            $("#general-pos-3").addClass("green-tag")
            $("#general-pos-3").removeClass("red-tag")
            $("#general-pos-1").removeClass("green-tag")
            $("#general-pos-2").removeClass("green-tag")
            $("#general-pos-4").removeClass("green-tag")
            $("#general-pos-1").addClass("red-tag")
            $("#general-pos-2").addClass("red-tag")
            $("#general-pos-4").addClass("red-tag")
        } else if (this.id == "general-pos-4") {
            $("#general-pos-4").addClass("green-tag")
            $("#general-pos-4").removeClass("red-tag")
            $("#general-pos-1").removeClass("green-tag")
            $("#general-pos-2").removeClass("green-tag")
            $("#general-pos-3").removeClass("green-tag")
            $("#general-pos-1").addClass("red-tag")
            $("#general-pos-2").addClass("red-tag")
            $("#general-pos-3").addClass("red-tag")
        }

        if (this.id == "vehicle-pos-1") {
            $("#vehicle-pos-1").addClass("green-tag")
            $("#vehicle-pos-1").removeClass("red-tag")
            $("#vehicle-pos-2").removeClass("green-tag")
            $("#vehicle-pos-3").removeClass("green-tag")
            $("#vehicle-pos-4").removeClass("green-tag")
            $("#vehicle-pos-2").addClass("red-tag")
            $("#vehicle-pos-3").addClass("red-tag")
            $("#vehicle-pos-4").addClass("red-tag")
        } else if (this.id == "vehicle-pos-2") {
            $("#vehicle-pos-2").addClass("green-tag")
            $("#vehicle-pos-2").removeClass("red-tag")
            $("#vehicle-pos-1").removeClass("green-tag")
            $("#vehicle-pos-3").removeClass("green-tag")
            $("#vehicle-pos-4").removeClass("green-tag")
            $("#vehicle-pos-1").addClass("red-tag")
            $("#vehicle-pos-3").addClass("red-tag")
            $("#vehicle-pos-4").addClass("red-tag")
        } else if (this.id == "vehicle-pos-3") {
            $("#vehicle-pos-3").addClass("green-tag")
            $("#vehicle-pos-3").removeClass("red-tag")
            $("#vehicle-pos-1").removeClass("green-tag")
            $("#vehicle-pos-2").removeClass("green-tag")
            $("#vehicle-pos-4").removeClass("green-tag")
            $("#vehicle-pos-1").addClass("red-tag")
            $("#vehicle-pos-2").addClass("red-tag")
            $("#vehicle-pos-4").addClass("red-tag")
        }
    })

    $(".hud-options").on("click", ".hud-options-save", function () {
        const showHealth = $("#health").prop('checked')
        const showHunger = $("#hunger").prop('checked')
        const showThirst = $("#thirst").prop('checked')
        const showArmor = $("#armor").prop('checked')
        const showOxygen = $("#oxygen").prop('checked')
        const showStress = $("#stress").prop('checked')
        const showGear = $("#gear").prop('checked')
        const showDirection = $("#direction").prop('checked')
        const showLocation = $("#location").prop('checked')
        const showFuel = $("#fuel").prop('checked')
        const showSpeed = $("#speed").prop('checked')
        const showvCircle = $("#vcircle").prop('checked')
        const showSeatbelt = $("#seatbelt").prop('checked')

        var position = 0
        var vPosition = 0


        if ($("#general-pos-1").hasClass("green-tag")) {
            position = 1
        } else if ($("#general-pos-2").hasClass("green-tag")) {
            position = 2
        } else if ($("#general-pos-3").hasClass("green-tag")) {
            position = 3
        } else if ($("#general-pos-4").hasClass("green-tag")) {
            position = 4
        }

        if ($("#vehicle-pos-1").hasClass("green-tag")) {
            vPosition = 1
        } else if ($("#vehicle-pos-2").hasClass("green-tag")) {
            vPosition = 2
        } else if ($("#vehicle-pos-3").hasClass("green-tag")) {
            vPosition = 3
        } else if ($("#vehicle-pos-4").hasClass("green-tag")) {
            vPosition = 4
        }

        $.post('https://erp_hud/saveOptions', JSON.stringify({
            showHealth: showHealth,
            showHunger: showHunger,
            showThirst: showThirst,
            showArmor: showArmor,
            showOxygen: showOxygen,
            showStress: showStress,
            showVoice: showVoice,
            showGear: showGear,
            showDirection: showDirection,
            showLocation: showLocation,
            showFuel: showFuel,
            showSpeed: showSpeed,
            showvCircle: showvCircle,
            showSeatbelt: showSeatbelt,
            position: position,
            vPosition: vPosition,
        }));

    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://erp_hud/escape', JSON.stringify({}));
            $(".hud-options-container").slideUp(500)
            $(".hud-options-container").fadeOut(500)
        }
    }

    window.addEventListener('message', function (event) {
        const data = event.data;
        // Car related hud
        if (data.show) {
            // set carhud position            
            if (data.vPosition == 1) {
                $(".carhud-container").css("right", "68%");                
                $(".carhud-compass").css("left", "20%");
                $(".carhud-compass").css("text-align", "left");
                $(".carhud-container").css("bottom", "107px");
            } else if (data.vPosition == 2) {
                $(".carhud-container").css("right", "47.5%");
                $(".carhud-compass").css("left", "-185%");
                $(".carhud-compass").css("text-align", "center");
                $(".carhud-container").css("bottom", "80px");
            } else if (data.vPosition == 3) {
                $(".carhud-container").css("right", "2.0%");
                $(".carhud-compass").css("left", "-387%");
                $(".carhud-compass").css("text-align", "right");
                $(".carhud-container").css("bottom", "80px");
            }
            // set cardhud gear visibility
            if (data.showGear == 1) { $(".carhud-gear").hide(); $(".carhud-gear-text").hide() } else if (data.showGear == 2) { $(".carhud-gear").show(); $(".carhud-gear-text").show() }
            // set carhud direction/location visibility

            if (data.compass && data.location) {
                if (data.showDirection == 1 && data.showLocation == 1) { 
                    $(".carhud-compass").hide() } 
                else if (data.showDirection == 2 && data.showLocation == 2) { 
                    $(".carhud-compass").html(`[${data.compass}] ${data.location}`); 
                    $(".carhud-compass").show()  
                } 
                else if (data.showDirection == 1 && data.showLocation == 2) { 
                    $(".carhud-compass").html(`${data.location}`); $(".carhud-compass").show()
                } 
                else if (data.showDirection == 2 && data.showLocation == 1) { 
                    $(".carhud-compass").html(`[${data.compass}]`); $(".carhud-compass").show() 
                }
            }


            // set carhud fuel visibility
            if (data.showFuel == 1) { $(".carhud-fuel").hide() } else if (data.showFuel == 2 ) { $(".carhud-fuel").show() }
            // set carhud mph visibility
            if (data.showSpeed == 1) { $(".carhud-mph").hide() } else if (data.showSpeed == 2 ) { $(".carhud-mph").show() }
            // set carhud seatbelt visibility
            if (data.showSeatbelt == 1) { $(".seatbelt-icon").hide() } else if (data.showSeatbelt == 2 && data.seatbelt) { $(".seatbelt-icon").show() }
            // set carhud circle visibility
            if (data.showvCircle == 1) { 
                $(".vehicle-circle").hide()
             } else if (data.showvCircle == 2 ) { 
                $(".vehicle-circle").show() 
                const currRPM = data.rpm
                if (currRPM) {
                    if (currRPM >= 0.95) {
                        $(".circle-gradient1").attr("stop-color", "#ff0000")
                        $(".circle-gradient2").attr("stop-color", "#ff0040")
                    } else if (currRPM >= 0.775) {
                        $(".circle-gradient1").attr("stop-color", "#ffa600")
                        $(".circle-gradient2").attr("stop-color", "#ff9100")
                    } else {
                        $(".circle-gradient1").attr("stop-color", "#0094FF")
                        $(".circle-gradient2").attr("stop-color", "#00E0FF")
                    }
                }
            }

            if (data.speed) {
                $(".carhud-mph").html(data.speed);
            }
            
            if (data.gear == 0) {
                $(".carhud-gear").html("R");
            } else {
                if (data.gear == 1) {
                    $(".carhud-gear").html(`${data.gear}st`);
                } else if (data.gear == 2) {
                    $(".carhud-gear").html(`${data.gear}nd`);
                } else if (data.gear == 3) {
                    $(".carhud-gear").html(`${data.gear}rd`);
                } else if (data.gear == 4) {
                    $(".carhud-gear").html(`${data.gear}th`);
                } else if (data.gear == 5) {
                    $(".carhud-gear").html(`${data.gear}th`);
                } else if (data.gear == 6) {
                    $(".carhud-gear").html(`${data.gear}th`);
                } else if (data.gear == 7) {
                    $(".carhud-gear").html(`${data.gear}th`);
                } else if (data.gear == 8) {
                    $(".carhud-gear").html(`${data.gear}th`);
                } else if (data.gear == 9) {
                    $(".carhud-gear").html(`${data.gear}th`);
                } else if (data.gear == 10) {
                    $(".carhud-gear").html(`${data.gear}th`);
                } else if (data.gear == 11) {
                    $(".carhud-gear").html(`${data.gear}th`);
                } else if (data.gear == 12) {
                    $(".carhud-gear").html(`${data.gear}th`);
                }
                
            };

            
            if (data.fuel) {
                $(".carhud-fuel").html(`${Math.ceil(data.fuel)} Fuel`)
            }
            
           
            if (data.engineAlert) {
                $(".engine-alert").fadeIn(250);
            } else if (data.engineAlert == false) {
                $(".engine-alert").fadeOut(250);
            };

            if (data.seatbelt && data.showSeatbelt == 2) {
                $(".seatbelt-icon").fadeIn(250);
            } else if (data.seatbelt == false) {
                $(".seatbelt-icon").fadeOut(250);
            };
                        
        } else if (data.show == false) {
           $(".carhud-container").css("bottom", "-20%");
        }  ;
        // END CAR HUD
        if (data.update == "playerHud") {
            if (data.showhud) {
                $(".hud-container").css("bottom","2%");
            } else if (data.showhud == false) {
                $(".hud-container").css("bottom","-20%");
            }
            if (data.inVehicle == true) {
                $(".hud-container").css("transition", "left 0.50s")
                $(".hud-container").css("left", "27.5vh");
            } else if (data.inVehicle == false) { 
                $(".hud-container").css("left", "0vh");
            }

            if (data.talking == true) { 
                if (data.radio == true) {
                    $(".progress .track2, .progress .fill2").css("fill", "#16bcca")
                } else {
                    $(".progress .track2, .progress .fill2").css("fill", "#dc00e7")
                }
                
            } else if (data.talking == false) { 
                $(".progress .track2, .progress .fill2").css("fill", "#dfdfdf") 
            }

            $(".health-hex").data("progress", data.health)
            $(".armor-hex").data("progress", data.armor)
            $(".hunger-hex").data("progress", data.hunger)
            $(".thirst-hex").data("progress", data.thirst)
            $(".stress-hex").data("progress", data.stress)
            $(".oxygen-hex").data("progress", data.oxygen)

            if (data.KVPshowVoice == 2) {
                $(".voice-hex1").fadeIn(250)
                $(".voice-hex2").fadeIn(250)
                $(".voice-hex3").fadeIn(250)
            } else if (data.KVPshowVoice == 1) {
                $(".voice-hex1").fadeOut(500)
                $(".voice-hex2").fadeOut(500)
                $(".voice-hex3").fadeOut(500)
            }

            if (data.KVPshowHealth == 2) {
                if (data.showHealth == false) {
                    $(".health-hex").css("opacity", "0.15")
                    $(".health-icon").css("opacity", "0.15")
                    $(".health-hex").fadeIn(250)
                    $(".health-icon").fadeIn(250)
                } else if (data.showHealth == true) {
                    $(".health-hex").css("opacity", "1")
                    $(".health-icon").css("opacity", "1")
                    $(".health-hex").fadeIn(250)
                    $(".health-icon").fadeIn(250)
                }
            } else if (data.KVPshowHealth == 1) {
                $(".health-hex").fadeOut(500)
                $(".health-icon").fadeOut(500)
            }

            if (data.KVPshowArmor == 2) {
                if (data.showArmor == false) {
                    $(".armor-hex").css("opacity", "0.15")
                    $(".armor-icon").css("opacity", "0.15")
                    $(".armor-hex").fadeIn(250)
                    $(".armor-icon").fadeIn(250)
                } else if (data.showArmor == true) {
                    $(".armor-hex").css("opacity", "1")
                    $(".armor-icon").css("opacity", "1")
                    $(".armor-hex").fadeIn(250)
                    $(".armor-icon").fadeIn(250)
                }
            } else if (data.KVPshowArmor == 1) {
                $(".armor-hex").fadeOut(500)
                $(".armor-icon").fadeOut(500)
            }

            if (data.KVPshowHunger == 2) {
                if (data.showHunger == false) {
                    $(".hunger-hex").css("opacity", "0.15")
                    $(".hunger-icon").css("opacity", "0.15")
                    $(".hunger-hex").fadeIn(250)
                    $(".hunger-icon").fadeIn(250)
                } else if (data.showHunger == true) {
                    $(".hunger-hex").css("opacity", "1")
                    $(".hunger-icon").css("opacity", "1")
                    $(".hunger-hex").fadeIn(250)
                    $(".hunger-icon").fadeIn(250)
                }
            } else if (data.KVPshowHunger == 1) {
                $(".hunger-hex").fadeOut(500)
                $(".hunger-icon").fadeOut(500)
            }

            if (data.KVPshowThirst == 2) {
                if (data.showThirst == false) {
                    $(".thirst-hex").css("opacity", "0.15")
                    $(".thirst-icon").css("opacity", "0.15")
                    $(".thirst-hex").fadeIn(250)
                    $(".thirst-icon").fadeIn(250)
                } else if (data.showThirst == true) {
                    $(".thirst-hex").css("opacity", "1")
                    $(".thirst-icon").css("opacity", "1")
                    $(".thirst-hex").fadeIn(250)
                    $(".thirst-icon").fadeIn(250)
                }
            } else if (data.KVPshowThirst == 1) {
                $(".thirst-hex").fadeOut(500)
                $(".thirst-icon").fadeOut(500)
            }
            
            if (data.KVPshowStress == 2) {
                if (data.showStress == false) {
                    $(".stress-hex").css("opacity", "0.15")
                    $(".stress-icon").css("opacity", "0.15")
                    $(".stress-hex").fadeIn(250)
                    $(".stress-icon").fadeIn(250)
                } else if (data.showStress == true) {
                    $(".stress-hex").css("opacity", "1")
                    $(".stress-icon").css("opacity", "1")
                    $(".stress-hex").fadeIn(250)
                    $(".stress-icon").fadeIn(250)
                }
            } else if (data.KVPshowStress == 1) {
                $(".stress-hex").fadeOut(500)
                $(".stress-icon").fadeOut(500)
            }
            
            if (data.KVPshowOxygen == 2) {
                if (data.showOxygen == false) {
                    $(".oxygen-hex").css("opacity", "0.15")
                    $(".oxygen-icon").css("opacity", "0.15")
                    $(".oxygen-hex").fadeIn(250)
                    $(".oxygen-icon").fadeIn(250)
                } else if (data.showOxygen == true) {
                    $(".oxygen-hex").css("opacity", "1")
                    $(".oxygen-icon").css("opacity", "1")
                    $(".oxygen-hex").fadeIn(250)
                    $(".oxygen-icon").fadeIn(250)
                }
            } else if (data.KVPshowOxygen == 1) {
                $(".oxygen-hex").fadeOut(500)
                $(".oxygen-icon").fadeOut(500)
            }

        } else if (data.update == "hudOptions") {
            $(".hud-options-container").slideDown(500)
            $(".hud-options-container").fadeIn(500)
            $("#health").prop('checked', data.showHealth == 2)
            $("#hunger").prop('checked', data.showHunger == 2);
            $("#thirst").prop('checked', data.showThirst == 2);
            $("#armor").prop('checked', data.showArmor == 2);
            $("#oxygen").prop('checked', data.showOxygen == 2);
            $("#stress").prop('checked', data.showStress == 2);

            if (data.position == 1) {
                $("#general-pos-1").addClass("green-tag")
                $("#general-pos-1").removeClass("red-tag")
                $("#general-pos-2").removeClass("green-tag")
                $("#general-pos-3").removeClass("green-tag")
                $("#general-pos-4").removeClass("green-tag")
                $("#general-pos-2").addClass("red-tag")
                $("#general-pos-3").addClass("red-tag")
                $("#general-pos-4").addClass("red-tag")
            } else if (data.position == 2) {
                $("#general-pos-2").addClass("green-tag")
                $("#general-pos-2").removeClass("red-tag")
                $("#general-pos-1").removeClass("green-tag")
                $("#general-pos-3").removeClass("green-tag")
                $("#general-pos-4").removeClass("green-tag")
                $("#general-pos-1").addClass("red-tag")
                $("#general-pos-3").addClass("red-tag")
                $("#general-pos-4").addClass("red-tag")
            } else if (data.position == 3) {
                $("#general-pos-3").addClass("green-tag")
                $("#general-pos-3").removeClass("red-tag")
                $("#general-pos-1").removeClass("green-tag")
                $("#general-pos-2").removeClass("green-tag")
                $("#general-pos-4").removeClass("green-tag")
                $("#general-pos-1").addClass("red-tag")
                $("#general-pos-2").addClass("red-tag")
                $("#general-pos-4").addClass("red-tag")
            } else if (data.position == 4) {
                $("#general-pos-4").addClass("green-tag")
                $("#general-pos-4").removeClass("red-tag")
                $("#general-pos-1").removeClass("green-tag")
                $("#general-pos-2").removeClass("green-tag")
                $("#general-pos-3").removeClass("green-tag")
                $("#general-pos-1").addClass("red-tag")
                $("#general-pos-2").addClass("red-tag")
                $("#general-pos-3").addClass("red-tag")
            }

            $("#gear").prop('checked', data.showGear == 2);
            $("#direction").prop('checked', data.showDirection == 2);
            $("#location").prop('checked', data.showLocation == 2);
            $("#fuel").prop('checked', data.showFuel == 2);
            $("#speed").prop('checked', data.showSpeed == 2);
            $("#vcircle").prop('checked', data.showvCircle == 2)

            if (data.vPosition == 1) {
                $("#vehicle-pos-1").addClass("green-tag")
                $("#vehicle-pos-1").removeClass("red-tag")
                $("#vehicle-pos-2").removeClass("green-tag")
                $("#vehicle-pos-3").removeClass("green-tag")
                $("#vehicle-pos-4").removeClass("green-tag")
                $("#vehicle-pos-2").addClass("red-tag")
                $("#vehicle-pos-3").addClass("red-tag")
                $("#vehicle-pos-4").addClass("red-tag")
            } else if (data.vPosition == 2) {
                $("#vehicle-pos-2").addClass("green-tag")
                $("#vehicle-pos-2").removeClass("red-tag")
                $("#vehicle-pos-1").removeClass("green-tag")
                $("#vehicle-pos-3").removeClass("green-tag")
                $("#vehicle-pos-4").removeClass("green-tag")
                $("#vehicle-pos-1").addClass("red-tag")
                $("#vehicle-pos-3").addClass("red-tag")
                $("#vehicle-pos-4").addClass("red-tag")
            } else if (data.vPosition == 3) {
                $("#vehicle-pos-3").addClass("green-tag")
                $("#vehicle-pos-3").removeClass("red-tag")
                $("#vehicle-pos-1").removeClass("green-tag")
                $("#vehicle-pos-2").removeClass("green-tag")
                $("#vehicle-pos-4").removeClass("green-tag")
                $("#vehicle-pos-1").addClass("red-tag")
                $("#vehicle-pos-2").addClass("red-tag")
                $("#vehicle-pos-4").addClass("red-tag")
            } else if (data.vPosition == 4) {
                $("#vehicle-pos-4").addClass("green-tag")
                $("#vehicle-pos-4").removeClass("red-tag")
                $("#vehicle-pos-1").removeClass("green-tag")
                $("#vehicle-pos-2").removeClass("green-tag")
                $("#vehicle-pos-3").removeClass("green-tag")
                $("#vehicle-pos-1").addClass("red-tag")
                $("#vehicle-pos-2").addClass("red-tag")
                $("#vehicle-pos-3").addClass("red-tag")
            }
        } else if (data.update == "voiceMode") {
            if (data.mode == 1) {
                $(".voice-hex1").css("opacity", "1")
                $(".voice-hex2").css("opacity", "0.15")
                $(".voice-hex3").css("opacity", "0.15")
            } else if (data.mode == 2) {
                $(".voice-hex1").css("opacity", "1")
                $(".voice-hex2").css("opacity", "1")
                $(".voice-hex3").css("opacity", "0.15")
            } else if (data.mode == 3) {
                $(".voice-hex1").css("opacity", "1")
                $(".voice-hex2").css("opacity", "1")
                $(".voice-hex3").css("opacity", "1")
            }
        };
    });
});