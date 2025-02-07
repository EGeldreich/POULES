function createDrop(x, y) {
    const drop = document.createElement("div");
    drop.className = "watercolor-drop";
    drop.style.left = x + "px";
    drop.style.top = y + "px";
    return drop;
}

function startWatercolorFill() {
    const area = document.getElementById("fillableArea");
    const dropCount = 5; // Number of initial drops
    const timeline = gsap.timeline();

    // Create multiple drops at random positions
    for (let i = 0; i < dropCount; i++) {
        const x = Math.random() * (area.offsetWidth - 50);
        const y = Math.random() * (area.offsetHeight - 50);
        const drop = createDrop(x, y);
        area.appendChild(drop);

        // Animate each drop with slightly different timing and scale
        timeline.fromTo(
            drop,
            {
                opacity: 0,
                width: "10px",
                height: "10px",
                scale: 0,
            },
            {
                opacity: 0.7,
                width: "100px",
                height: "100px",
                scale: Math.random() * 2 + 1.5,
                duration: Math.random() * 2 + 1,
                ease: "power1.inOut",
            },
            i * 0.2 // Stagger the start times
        );

        // Add random movement
        gsap.to(drop, {
            x: (Math.random() - 0.5) * 50,
            y: (Math.random() - 0.5) * 50,
            duration: Math.random() * 3 + 2,
            ease: "power1.inOut",
            repeat: -1,
            yoyo: true,
        });
    }
}
