import time
from threading import Thread
import sys

# Lyrics for "Bukan Cinta Biasa" - Siti Nurhaliza
# Format: (Text, typing_speed)
lyrics = [
    ("Cintaku bukan di atas kertas", 0.08),
    ("Cintaku getaran yang sama", 0.08),
    ("Tak perlu dipaksa", 0.08),
    ("Tak perlu dicari", 0.08),
    ("Kerna ku yakin ada jawabnya", 0.08),
    ("Andai ku bisa merubah semua", 0.08),
    ("Hingga tiada orang terluka", 0.08),
    ("Tapi tak mungkin", 0.08),
    ("Ku tak berdaya", 0.08),
    ("Hanya yakin menunggu jawabnya", 0.08)
]

# Timings in seconds to match the song's progression
delays = [0, 4.0, 8.0, 10.0, 12.0, 18.0, 22.0, 26.0, 28.0, 30.0]

def animate_text(text, delay=0.1):
    for char in text:
        sys.stdout.write(char)
        sys.stdout.flush()
        time.sleep(delay)
    print()

def sing_lyric(lyric, delay, speed):
    time.sleep(delay)
    animate_text(lyric, speed)

def sing_song():
    print("=== Bukan Cinta Biasa - Siti Nurhaliza ===\n")
    threads = []
    for i in range(len(lyrics)):
        lyric, speed = lyrics[i]
        t = Thread(target=sing_lyric, args=(lyric, delays[i], speed))
        threads.append(t)
        t.start()
    for thread in threads:
        thread.join()

if __name__ == "__main__":
    try:
        sing_song()
    except KeyboardInterrupt:
        print("\nStopped.")
