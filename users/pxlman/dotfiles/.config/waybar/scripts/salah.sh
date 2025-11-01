#!/usr/bin/env bash

case "$1" in
    bar)
        # Minimal, fast, single-line output
        nsalah
        ;;
    tooltip)
        # Detailed info, can take a bit longer
        {
            echo "Salah Time"
            echo "Current Salah times for your location:"
            echo "Fajr: $(nsalah fajr)"
            echo "Sunrise: $(nsalah sunrise)"
            echo "Dhuhr: $(nsalah dhuhr)"
            echo "Asr: $(nsalah asr)"
            echo "Maghrib: $(nsalah maghrib)"
            echo "Isha: $(nsalah isha)"
        }
        ;;
esac

