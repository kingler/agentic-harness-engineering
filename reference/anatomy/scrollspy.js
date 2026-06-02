/**
 * Scroll-spy for anatomy reference pages.
 *
 * Each .anatomy-code contains one or more <span class="anchor"> elements
 * tagged with data-section-id="N". Each .anatomy-card on the right side
 * is tagged with data-target-section="N". As the reader scrolls, the
 * topmost anchor inside an "active band" (positioned ~25% from the top
 * of the viewport) is selected; both the anchor and its card receive
 * the .is-active class.
 *
 * Cards are also clickable — clicking scrolls the matching anchor into
 * view (smooth) and immediately activates it.
 */
(() => {
  const sections = Array.from(document.querySelectorAll('[data-section-id]'));
  const cards = Array.from(document.querySelectorAll('[data-target-section]'));
  if (!sections.length || !cards.length) return;

  // Lookup tables — DOM order matters for tie-breaking later.
  const sectionById = new Map();
  sections.forEach((el) => sectionById.set(el.dataset.sectionId, el));

  const cardById = new Map();
  cards.forEach((el) => cardById.set(el.dataset.targetSection, el));

  let currentId = null;

  function setActive(id) {
    if (id === currentId) return;
    currentId = id;
    sectionById.forEach((el, sid) => el.classList.toggle('is-active', sid === id));
    cardById.forEach((el, sid) => {
      const on = sid === id;
      el.classList.toggle('is-active', on);
      el.setAttribute('aria-current', on ? 'true' : 'false');
    });
  }

  // Track which sections are currently intersecting the active band so we
  // can always pick the topmost one (in document order) as the active one.
  const intersecting = new Set();

  const observer = new IntersectionObserver(
    (entries) => {
      for (const entry of entries) {
        if (entry.isIntersecting) intersecting.add(entry.target);
        else intersecting.delete(entry.target);
      }
      let topmost = null;
      for (const s of sections) {
        if (intersecting.has(s)) { topmost = s; break; }
      }
      if (topmost) {
        setActive(topmost.dataset.sectionId);
      } else if (currentId === null && sections.length) {
        // Nothing in band yet (page just loaded) — light up the first card.
        setActive(sections[0].dataset.sectionId);
      }
    },
    {
      // Active band: between 22% and 55% from the top of the viewport.
      // Sections passing through this band get highlighted.
      rootMargin: '-22% 0px -55% 0px',
      threshold: 0,
    }
  );

  sections.forEach((s) => observer.observe(s));

  // Initial highlight — first section, so the page isn't blank on load.
  if (sections.length) setActive(sections[0].dataset.sectionId);

  // Click a card → scroll to its section + activate immediately.
  cards.forEach((card) => {
    const handler = (e) => {
      const id = card.dataset.targetSection;
      const target = sectionById.get(id);
      if (!target) return;
      e.preventDefault();
      setActive(id);
      // Center multi-line code anchors so the full highlight (e.g. PreToolUse JSON)
      // stays inside the viewport; block:start aligns the span top flush with the
      // scrollport and clips tall highlighted regions.
      target.scrollIntoView({ behavior: 'smooth', block: 'center', inline: 'nearest' });
    };
    card.addEventListener('click', handler);
    card.setAttribute('role', 'button');
    card.setAttribute('tabindex', '0');
    card.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') handler(e);
    });
  });
})();
