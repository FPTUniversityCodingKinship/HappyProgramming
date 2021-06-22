/* 
    Created on : Jun 22, 2021, 5:56:03 PM
    Author     : Admin
*/
                    //DON'T BE WORRY ABOUT THIS FACKEN' BULLSHIT ERROR//
const numberOfNodes = 80;
const connectionRange = 200;
const connectLineWidth = 1;
const moveSpeed = 0.5 + Math.random() * 2;
const particleRadius = 5;

((d) => {
  const c = d.querySelector("#background");
  const ctx = c.getContext("2d");

  c.width = innerWidth;
  c.height = innerHeight;

  class Particles {
    constructor({ x, y, color, radius, d }) {
      this.x = x;
      this.y = y;
      this.color = color;
      this.radius = radius;
      this.d = d;
      this.lineWidth = connectLineWidth;
      this.range = connectionRange;
    }

    update(particles) {
      const length = particles.length;
      this.d = border(this.x, this.y, this.d, this.radius);

      this.x += this.d.x;
      this.y += this.d.y;

      for (let i = 0; i < length; i++) {
        if (this === particles[i]) continue;
        const dist = distance(this, particles[i]);
        if (dist < this.range) {
          ctx.lineWidth = this.lineWidth;
          ctx.strokeStyle = `rgba(55,255,255,${1 - dist / this.range})`;
          ctx.beginPath();
          ctx.moveTo(this.x, this.y);
          ctx.lineTo(particles[i].x, particles[i].y);
          ctx.stroke();
          ctx.closePath();
        }
      }

      this.draw();
    }

    draw() {
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
      ctx.fillStyle = this.color;
      ctx.fill();
      ctx.closePath();
    }
  }

  let particles;

  const init = (e) => {
    c.width = innerWidth;
    c.height = innerHeight;

    const particlesLenght = numberOfNodes;
    particles = [];

    for (let i = 0; i < particlesLenght; i++) {
      particles.push(new Particles(setup()));
    }
  };

  const distance = (p1, p2) => {
    return Math.hypot(p1.x - p2.x, p1.y - p2.y);
  };

  const border = (x, y, d, radius) => {
    if (x + radius >= c.width || x - radius <= 0) {
      d.x = -d.x;
    }

    if (y + radius >= c.height || y - radius <= 0) {
      d.y = -d.y;
    }

    return { x: d.x, y: d.y };
  };

  const animation = () => {
    //stats.begin();
    
    ctx.clearRect(0, 0, c.width, c.height);
    particles.forEach((particle) => {
      particle.update(particles);
    });

    requestAnimationFrame(animation);

    //stats.end();
  };

  const addParticle = (e) => {
    particles.push(new Particles(setup(e)));
    
    console.log(particles.length)
  };

  const setup = (e = false) => {
    const degrees = 360;
    const radius = particleRadius;
    const { x, y } = mouseOnCanvas(e, radius, c);
    const speed = moveSpeed;
    const directionAngle = Math.floor(Math.random() * degrees);
    const color = "rgba(55,255,255,1)";

    const d = {
      x: Math.cos(directionAngle) * speed,
      y: Math.sin(directionAngle) * speed
    };
    return { x, y, color, radius, d };
  };

  const mouseOnCanvas = (e, radius, c) => {
    const bounding = c.getBoundingClientRect();
    const mx =
      e.clientX - bounding.left || minMax(0 + radius, c.width - radius);
    const my =
      e.clientY - bounding.top || minMax(0 + radius, c.height - radius);

    const xInCanvas =
      mx <= radius
        ? mx + radius + 0.5
        : mx + radius >= c.width
        ? mx - radius - 0.5
        : mx;
    const yInCanvas =
      my <= radius
        ? my + radius + 0.5
        : my + radius >= c.height
        ? my - radius - 0.5
        : my;

    return { x: xInCanvas, y: yInCanvas };
  };

  const minMax = (min, max) => Math.random() * (max - min) + min;

  const deleteParticle = (e) => {
    e.preventDefault();
    if (particles.length) particles.pop();
  };

  init();
  requestAnimationFrame(animation);
  window.addEventListener("resize", init);
  c.addEventListener("click", (e) => addParticle(e));
  c.addEventListener("contextmenu", (e) => deleteParticle(e));

})(document);
