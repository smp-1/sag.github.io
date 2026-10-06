# Architecture Design System - Elect27

## 1. Design Tokens (DTCG 3-Tier)

### 1.1 Primitive Tokens - Couleurs

```json
{
  "color": {
    "primitive": {
      "blue": {
        "50": "#eff6ff",
        "100": "#dbeafe",
        "200": "#bfdbfe",
        "300": "#93c5fd",
        "400": "#60a5fa",
        "500": "#3b82f6",
        "600": "#2563eb",
        "700": "#1d4ed8",
        "800": "#1e40af",
        "900": "#1e3a8a"
      },
      "emerald": {
        "50": "#ecfdf5",
        "100": "#d1fae5",
        "200": "#a7f3d0",
        "300": "#6ee7b7",
        "400": "#34d399",
        "500": "#10b981",
        "600": "#059669",
        "700": "#047857",
        "800": "#065f46",
        "900": "#064e3b"
      },
      "rose": {
        "50": "#fff1f2",
        "100": "#ffe4e6",
        "200": "#fecdd3",
        "300": "#fda4af",
        "400": "#fb7185",
        "500": "#f43f5e",
        "600": "#e11d48",
        "700": "#be123c",
        "800": "#9f1239",
        "900": "#881337"
      },
      "amber": {
        "50": "#fffbeb",
        "100": "#fef3c7",
        "200": "#fde68a",
        "300": "#fcd34d",
        "400": "#fbbf24",
        "500": "#f59e0b",
        "600": "#d97706",
        "700": "#b45309",
        "800": "#92400e",
        "900": "#78350f"
      },
      "slate": {
        "50": "#f8fafc",
        "100": "#f1f5f9",
        "200": "#e2e8f0",
        "300": "#cbd5e1",
        "400": "#94a3b8",
        "500": "#64748b",
        "600": "#475569",
        "700": "#334155",
        "800": "#1e293b",
        "900": "#0f172a"
      },
      "white": "#ffffff",
      "black": "#000000"
    }
  }
}
```

### 1.2 Semantic Tokens

```json
{
  "color": {
    "semantic": {
      "primary": {
        "default": "#2563eb",
        "hover": "#1d4ed8",
        "active": "#1e40af",
        "light": "#dbeafe",
        "dark": "#1e3a8a"
      },
      "secondary": {
        "default": "#64748b",
        "hover": "#475569",
        "active": "#334155",
        "light": "#f1f5f9",
        "dark": "#0f172a"
      },
      "success": {
        "default": "#10b981",
        "hover": "#059669",
        "active": "#047857",
        "light": "#d1fae5",
        "dark": "#064e3b"
      },
      "warning": {
        "default": "#f59e0b",
        "hover": "#d97706",
        "active": "#b45309",
        "light": "#fef3c7",
        "dark": "#78350f"
      },
      "danger": {
        "default": "#ef4444",
        "hover": "#dc2626",
        "active": "#b91c1c",
        "light": "#fee2e2",
        "dark": "#7f1d1d"
      },
      "info": {
        "default": "#3b82f6",
        "hover": "#2563eb",
        "active": "#1d4ed8",
        "light": "#dbeafe",
        "dark": "#1e3a8a"
      },
      "neutral": {
        "default": "#64748b",
        "hover": "#475569",
        "active": "#334155",
        "light": "#f1f5f9",
        "dark": "#0f172a"
      }
    },
    "surface": {
      "background": "#ffffff",
      "foreground": "#0f172a",
      "card": "#ffffff",
      "cardForeground": "#0f172a",
      "popover": "#ffffff",
      "popoverForeground": "#0f172a",
      "muted": "#f1f5f9",
      "mutedForeground": "#64748b",
      "accent": "#f1f5f9",
      "accentForeground": "#0f172a",
      "destructive": "#fee2e2",
      "destructiveForeground": "#7f1d1d",
      "border": "#e2e8f0",
      "input": "#e2e8f0",
      "ring": "#2563eb"
    }
  }
}
```

### 1.3 Component Tokens

```json
{
  "color": {
    "component": {
      "button": {
        "primary": {
          "bg": "#2563eb",
          "bgHover": "#1d4ed8",
          "bgActive": "#1e40af",
          "text": "#ffffff",
          "border": "transparent"
        },
        "secondary": {
          "bg": "#ffffff",
          "bgHover": "#f1f5f9",
          "bgActive": "#e2e8f0",
          "text": "#334155",
          "border": "#e2e8f0"
        },
        "ghost": {
          "bg": "transparent",
          "bgHover": "#f1f5f9",
          "bgActive": "#e2e8f0",
          "text": "#334155",
          "border": "transparent"
        },
        "danger": {
          "bg": "#ef4444",
          "bgHover": "#dc2626",
          "bgActive": "#b91c1c",
          "text": "#ffffff",
          "border": "transparent"
        }
      },
      "input": {
        "bg": "#ffffff",
        "bgDisabled": "#f1f5f9",
        "border": "#e2e8f0",
        "borderFocus": "#2563eb",
        "borderError": "#ef4444",
        "text": "#0f172a",
        "textPlaceholder": "#94a3b8",
        "textDisabled": "#94a3b8"
      },
      "card": {
        "bg": "#ffffff",
        "border": "#e2e8f0",
        "shadow": "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)"
      },
      "header": {
        "bg": "#ffffff",
        "border": "#e2e8f0",
        "text": "#0f172a"
      },
      "sidebar": {
        "bg": "#ffffff",
        "border": "#e2e8f0",
        "text": "#334155",
        "textActive": "#2563eb",
        "bgActive": "#dbeafe"
      },
      "map": {
        "marker": "#2563eb",
        "markerHover": "#1d4ed8",
        "markerActive": "#1e40af",
        "userPosition": "#10b981"
      }
    }
  }
}
```

### 1.4 Typography Tokens

```json
{
  "typography": {
    "fontFamily": {
      "sans": "Inter, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif",
      "mono": "JetBrains Mono, ui-monospace, SFMono-Regular, 'SF Mono', Menlo, Consolas, 'Liberation Mono', monospace"
    },
    "fontSize": {
      "xs": "0.75rem",
      "sm": "0.875rem",
      "base": "1rem",
      "lg": "1.125rem",
      "xl": "1.25rem",
      "2xl": "1.5rem",
      "3xl": "1.875rem",
      "4xl": "2.25rem",
      "5xl": "3rem"
    },
    "fontWeight": {
      "normal": "400",
      "medium": "500",
      "semibold": "600",
      "bold": "700"
    },
    "lineHeight": {
      "none": "1",
      "tight": "1.25",
      "snug": "1.375",
      "normal": "1.5",
      "relaxed": "1.625",
      "loose": "2"
    },
    "letterSpacing": {
      "tighter": "-0.05em",
      "tight": "-0.025em",
      "normal": "0em",
      "wide": "0.025em",
      "wider": "0.05em",
      "widest": "0.1em"
    }
  }
}
```

### 1.5 Spacing Tokens

```json
{
  "spacing": {
    "0": "0px",
    "1": "0.25rem",
    "2": "0.5rem",
    "3": "0.75rem",
    "4": "1rem",
    "5": "1.25rem",
    "6": "1.5rem",
    "8": "2rem",
    "10": "2.5rem",
    "12": "3rem",
    "16": "4rem",
    "20": "5rem",
    "24": "6rem",
    "32": "8rem",
    "40": "10rem",
    "48": "12rem",
    "64": "16rem"
  }
}
```

### 1.6 Border Radius Tokens

```json
{
  "borderRadius": {
    "none": "0px",
    "sm": "0.375rem",
    "md": "0.5rem",
    "lg": "0.75rem",
    "xl": "1rem",
    "2xl": "1.5rem",
    "full": "9999px"
  }
}
```

### 1.7 Shadow Tokens

```json
{
  "boxShadow": {
    "sm": "0 1px 2px 0 rgb(0 0 0 / 0.05)",
    "md": "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)",
    "lg": "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)",
    "xl": "0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1)",
    "2xl": "0 25px 50px -12px rgb(0 0 0 / 0.25)",
    "inner": "inset 0 2px 4px 0 rgb(0 0 0 / 0.05)",
    "focus": "0 0 0 3px rgb(37 99 235 / 0.3)"
  }
}
```

### 1.8 Breakpoint Tokens

```json
{
  "breakpoint": {
    "sm": "640px",
    "md": "768px",
    "lg": "1024px",
    "xl": "1280px",
    "2xl": "1536px"
  }
}
```

### 1.9 Z-Index Tokens

```json
{
  "zIndex": {
    "dropdown": "1000",
    "sticky": "1020",
    "fixed": "1030",
    "modalBackdrop": "1040",
    "modal": "1050",
    "popover": "1060",
    "tooltip": "1070",
    "toast": "1080"
  }
}
```

### 1.10 Transition Tokens

```json
{
  "transition": {
    "duration": {
      "fast": "150ms",
      "normal": "250ms",
      "slow": "350ms",
      "slower": "500ms"
    },
    "timingFunction": {
      "ease": "cubic-bezier(0.4, 0, 0.2, 1)",
      "easeIn": "cubic-bezier(0.4, 0, 1, 1)",
      "easeOut": "cubic-bezier(0, 0, 0.2, 1)",
      "easeInOut": "cubic-bezier(0.4, 0, 0.2, 1)",
      "bounce": "cubic-bezier(0.34, 1.56, 0.64, 1)"
    }
  }
}
```

## 2. Composants Reutilisables

### 2.1 Composants Atomes

| Composant | Description | Tokens utilises |
|-----------|-------------|-----------------|
| Button | Bouton principal, secondaire, ghost, danger | button.*, borderRadius, transition |
| Input | Champ de texte, recherche | input.*, borderRadius, transition |
| Badge | Etiquette de statut | semantic.*, borderRadius |
| Icon | Pictogramme vectoriel | N/A |
| Label | Etiquette de champ | typography, surface.* |
| Avatar | Photo de profil | borderRadius.full, sizing |

### 2.2 Composants Molecules

| Composant | Description | Tokens utilises |
|-----------|-------------|-----------------|
| FormField | Champ avec label et message | input.*, label, spacing |
| SearchBar | Barre de recherche avec suggestions | input.*, button.*, spacing |
| Card | Carte d'information | card.*, shadow.*, borderRadius |
| Alert | Message d'alerte | semantic.*, spacing |
| StatCard | Carte de statistique | card.*, semantic.*, typography |

### 2.3 Composants Organismes

| Composant | Description | Tokens utilises |
|-----------|-------------|-----------------|
| Header | Barre de navigation superieure | header.*, spacing, typography |
| Sidebar | Menu lateral (admin) | sidebar.*, spacing |
| Footer | Pied de page | surface.*, typography, spacing |
| MapContainer | Conteneur de carte Leaflet | map.*, sizing |
| DataTable | Tableau de donnees | card.*, input.*, typography |
| Modal | Fenetre modale | modal.*, shadow.*, borderRadius |

### 2.4 Composants Templates

| Composant | Description |
|-----------|-------------|
| HomePage | Page d'accueil avec recherche et carte |
| SearchPage | Page de recherche avancee |
| MapPage | Page carte interactive plein ecran |
| AdminDashboard | Tableau de bord administrateur |
| AdminCentres | Gestion des centres de vote |
| AdminBureaux | Gestion des bureaux de vote |
| AdminElecteurs | Gestion des electeurs |
| LoginPage | Page de connexion admin |

## 3. Layout Responsive

### 3.1 Grille

```
Mobile (sm):    1 colonne    - padding: 16px
Tablette (md):  2 colonnes   - padding: 24px
Desktop (lg):   12 colonnes  - padding: 32px, max-width: 1280px
Large (xl):     12 colonnes  - padding: 48px, max-width: 1440px
```

### 3.2 Navigation

```
Mobile:    Hamburger menu (bottom sheet)
Tablette:  Sidebar collapsee (icônes)
Desktop:   Sidebar expandee (labels + icons)
```

### 3.3 Carte Interactive

```
Mobile:    Pleine largeur, controls en bas
Tablette:  Pleine largeur, controls sur le cote
Desktop:   70% largeur + panel details 30%
```

## 4. Accessibilite (WCAG 2.2 AA)

### 4.1 Contraste

| Element | Ratio minimum | Couleurs testees |
|---------|---------------|------------------|
| Texte normal | 4.5:1 | primary-dark sur white |
| Texte large | 3:1 | primary sur white |
| Icons | 3:1 | primary sur white |
| Focus ring | 3:1 | primary sur white |

### 4.2 Touch Targets

| Element | Taille minimum |
|---------|----------------|
| Boutons | 44x44px |
| Links | 44x44px |
| Inputs | 44x44px |
| Map markers | 44x44px |

### 4.3 Keyboard Navigation

- Tab order logique (header > main > footer)
- Focus visible avec ring primary
- Skip links pour navigation rapide
- Escape pour fermer modals/menus

### 4.4 Screen Reader

- ARIA labels sur tous les elements interactifs
- Roles ARIA composites (search, navigation, main)
- Live regions pour mises a jour dynamiques
- Alt text sur images decoratives

## 5. Performance

### 5.1 Lazy Loading

- Images: loading="lazy"
- Composants lourds: Intersection Observer
- Routes: dynamic imports

### 5.2 Cache

- API: Cache-Control headers
- Assets: Hash dans les noms de fichiers
- Service Worker pour offline

### 5.3 Optimization

- CSS: Purge Tailwind (suppression classes inutilisees)
- JS: Tree shaking, minification
- Images: WebP, responsive sizes

## 6. Securite

### 6.1 Headers

```
Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:;
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), camera=(), microphone=()
```

### 6.2 Authentification

- JWT access token (15 min)
- Refresh token (7 jours)
- HttpOnly cookies pour refresh token
- CSRF protection

### 6.3 Validation

- Cote serveur: Marshmallow schemas
- Cote client: HTML5 validation + JS
- Sanitization: escape HTML entities
- Rate limiting: 100 req/min
