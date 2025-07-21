# Branding Assets Usage Guide

## 📋 Complete Assets Table

| Filename | Format | Corner Type | Size (px) | Proportional Size | Usage |
|----------|---------|-------------|-----------|-------------------|--------|
| `logo-master-2000px.png` | PNG | **Sharp** | 2000×2000 | ████████████████████ | Master file, print, high-res |
| `logo-github-420px.png` | PNG | **Sharp** | 420×420 | ████████ | GitHub organization avatar |
| `logo-social-400px.png` | PNG | **Sharp** | 400×400 | ████████ | Twitter, LinkedIn profile |
| `logo-facebook-170px.png` | PNG | **Sharp** | 170×170 | ████ | Facebook profile |
| `logo-whatsapp-640px.png` | PNG | **Sharp** | 640×640 | ████████████ | WhatsApp Business profile |
| `logo-horizontal-800px.png` | PNG | **Sharp** | 800×200 | ████████████████ | Website headers, banners |
| `logo-horizontal-600px.png` | PNG | **Sharp** | 600×150 | ████████████ | Medium headers |
| `logo-horizontal-400px.png` | PNG | **Sharp** | 400×100 | ████████ | Small headers |
| `logo-vector.svg` | SVG | **Sharp** | Scalable | ∞ | All web uses, ultimate flexibility |
| `favicon-32px.png` | PNG | **Sharp** | 32×32 | ██ | Browser tab icon |
| `favicon-16px.png` | PNG | **Sharp** | 16×16 | █ | Browser tab icon (small) |
| `favicon.ico` | ICO | **Sharp** | 16×16,32×32 | █ | Legacy browser support |
| `social-sharing-1200px.png` | PNG | **Sharp** | 1200×630 | ████████████████████ | Open Graph, Twitter cards |
| `social-sharing-1200px-wide.png` | PNG | **Sharp** | 1200×600 | ████████████████████ | Twitter card specific |
| `app-icon-1024px.png` | PNG | **Rounded (15%)** | 1024×1024 | ████████████████ | PWA, future mobile app |
| `app-icon-ios-1024px.png` | PNG | **Rounded (20%)** | 1024×1024 | ████████████████ | iOS App Store |
| `app-icon-android-512px.png` | PNG | **Rounded (10%)** | 512×512 | ██████████ | Android Play Store |
| `card-thumbnail-200px.png` | PNG | **Rounded (8%)** | 200×200 | ████ | Website cards, thumbnails |
| `presentation-slide-1920px.png` | PNG | **Sharp** | 1920×1080 | ████████████████████ | Slides, presentations |
| `business-card-300dpi.png` | PNG | **Sharp** | 600×600 | ████████████ | Print materials (300 DPI) |
| `logo-white-version.png` | PNG | **Sharp** | 2000×2000 | ████████████████████ | Dark backgrounds |
| `logo-black-version.png` | PNG | **Sharp** | 2000×2000 | ████████████████████ | Light backgrounds |

---

## 🌐 Website Implementation

### HTML Head Section
Add these to your website's `<head>` tag:

```html
<!-- Primary Logo for Website -->
<link rel="icon" type="image/svg+xml" href="/logo-vector.svg">

<!-- Favicon Support -->
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32px.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16px.png">
<link rel="shortcut icon" href="/favicon.ico">

<!-- Apple Touch Icon -->
<link rel="apple-touch-icon" sizes="180x180" href="/app-icon-1024px.png">

<!-- Web App Manifest -->
<link rel="manifest" href="/site.webmanifest">

<!-- Open Graph (Facebook, LinkedIn) -->
<meta property="og:image" content="/social-sharing-1200px.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">

<!-- Twitter Cards -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="/social-sharing-1200px-wide.png">
```

### Website Header Examples

**Main Navigation:**
```html
<header>
  <img src="/logo-horizontal-800px.png" alt="Your Brand" width="200" height="50">
</header>
```

**Compact Header:**
```html
<nav>
  <img src="/logo-horizontal-400px.png" alt="Your Brand" width="120" height="30">
</nav>
```

**SVG for Scalability:**
```html
<div class="logo">
  <img src="/logo-vector.svg" alt="Your Brand" style="height: 60px;">
</div>
```

---

## 📱 Social Media Platforms

### GitHub Organization
1. Go to your GitHub organization settings
2. Upload `logo-github-420px.png` as organization avatar
3. File location: `02-github/logo-github-420px.png`

### Twitter/X Profile
1. Profile picture: Use `logo-social-400px.png`
2. Header image: Use `logo-horizontal-800px.png` or custom design
3. File location: `03-social/logo-social-400px.png`

### LinkedIn Company Page
1. Logo: Use `logo-social-400px.png`
2. Cover image: Create custom design using `logo-horizontal-800px.png`
3. File location: `03-social/logo-social-400px.png`

### Facebook Business Page
1. Profile picture: Use `logo-facebook-170px.png`
2. Cover photo: Use `logo-horizontal-800px.png` in custom design
3. File location: `03-social/logo-facebook-170px.png`

### WhatsApp Business
1. Profile picture: Use `logo-whatsapp-640px.png`
2. **Important**: WhatsApp crops images into a circle - ensure logo elements are centered
3. Optimal size: 640×640 pixels (minimum 192×192, maximum 640×640)
4. File location: `03-social/logo-whatsapp-640px.png`
5. Format: PNG or JPG (PNG recommended for transparency)

**WhatsApp Setup Steps:**
1. Open WhatsApp Business app
2. Go to Settings → Business settings → Profile
3. Tap profile photo → Camera/Gallery
4. Upload `logo-whatsapp-640px.png`
5. Adjust positioning for circular crop

---

## 📧 Email & Communications

### Email Signatures
```html
<img src="logo-horizontal-400px.png" alt="Your Brand" width="150" height="38" style="max-width: 150px;">
```

### Business Cards
- Use `business-card-300dpi.png` for print materials
- 300 DPI ensures crisp printing
- File location: `06-future/business-card-300dpi.png`

### Presentations
- Use `presentation-slide-1920px.png` for PowerPoint/Google Slides
- Perfect for 16:9 aspect ratio slides
- File location: `06-future/presentation-slide-1920px.png`

---

## 📱 Mobile App Development

### Progressive Web App (PWA)
Create `site.webmanifest`:
```json
{
  "name": "Your Brand",
  "short_name": "YourBrand",
  "icons": [
    {
      "src": "/app-icon-1024px.png",
      "sizes": "1024x1024",
      "type": "image/png"
    },
    {
      "src": "/favicon-32px.png", 
      "sizes": "32x32",
      "type": "image/png"
    }
  ],
  "start_url": "/",
  "display": "standalone"
}
```

### iOS App Store
- Use `app-icon-ios-1024px.png` for App Store listing
- Apple applies 20% corner radius automatically
- File location: `06-future/app-icon-ios-1024px.png`

### Android Play Store
- Use `app-icon-android-512px.png` for Play Store listing  
- Google applies 10% corner radius automatically
- File location: `06-future/app-icon-android-512px.png`

---

## 🎨 Design System Integration

### Dark Mode Support
```css
/* Light theme */
.logo-light {
  background-image: url('/logo-master-2000px.png');
}

/* Dark theme */
.logo-dark {
  background-image: url('/logo-white-version.png');
}

/* Auto-switching */
@media (prefers-color-scheme: dark) {
  .logo {
    background-image: url('/logo-white-version.png');
  }
}
```

### Responsive Logo Sizing
```css
.logo {
  background-image: url('/logo-vector.svg');
  background-size: contain;
  background-repeat: no-repeat;
}

/* Mobile */
@media (max-width: 768px) {
  .logo {
    height: 40px;
    width: 160px;
  }
}

/* Desktop */
@media (min-width: 769px) {
  .logo {
    height: 60px; 
    width: 240px;
  }
}
```

---

## 🔧 File Placement Guide

### Website Root Directory
```
your-website/
├── favicon.ico
├── favicon-16px.png
├── favicon-32px.png
├── logo-vector.svg
├── site.webmanifest
└── assets/
    ├── logo-horizontal-800px.png
    ├── logo-horizontal-600px.png
    ├── logo-horizontal-400px.png
    ├── social-sharing-1200px.png
    └── app-icon-1024px.png
```

### CDN/Assets Folder
```
cdn.yourbrand.com/
├── branding/
│   ├── logo-master-2000px.png
│   ├── logo-vector.svg
│   ├── logo-white-version.png
│   ├── logo-black-version.png
│   └── social/
│       ├── logo-social-400px.png
│       ├── logo-facebook-170px.png
│       ├── logo-whatsapp-640px.png
│       └── social-sharing-1200px.png
```

---

## ✅ Quality Checklist

### Before Going Live
- [ ] Favicon appears correctly in browser tabs
- [ ] Logo displays properly on both light and dark backgrounds
- [ ] Social sharing images show correctly on Facebook/Twitter
- [ ] WhatsApp Business profile picture looks good in circular crop
- [ ] Mobile app icons have proper corner radius
- [ ] Email signatures render correctly across email clients
- [ ] Print materials use 300 DPI versions
- [ ] SVG logo scales cleanly at all sizes

### Cross-Platform Testing
- [ ] Test on Chrome, Firefox, Safari, Edge
- [ ] Check mobile responsiveness (iOS/Android)
- [ ] Verify social media previews
- [ ] Test email signature in Gmail, Outlook, Apple Mail
- [ ] Validate PWA manifest

---

## 🚀 Quick Reference

### Most Important Files (Start Here)
1. **`logo-vector.svg`** → Website header
2. **`favicon-32px.png`** → Browser tab icon  
3. **`logo-github-420px.png`** → GitHub organization
4. **`logo-whatsapp-640px.png`** → WhatsApp Business profile
5. **`social-sharing-1200px.png`** → Social media previews

### File Size Guidelines
- **Web use**: Prefer SVG or PNG under 100KB
- **Social media**: PNG optimized for platform requirements
- **Print**: Use 300 DPI versions (larger file sizes OK)
- **Email**: Keep under 50KB for faster loading

### When to Use Which Format
- **SVG**: Website headers, scalable icons
- **PNG**: Social media, favicons, when transparency needed
- **ICO**: Legacy browser favicon support
- **JPG**: Only for photography, not logos

### Platform-Specific Considerations
- **Instagram/WhatsApp**: Circular crop - center important elements
- **LinkedIn**: Professional context - use clean, high-contrast versions  
- **GitHub**: Sharp corners preferred - platform adds subtle rounding
- **Email**: Optimize for small sizes and slow connections

---

*Need help implementing any of these? Reference this guide and you'll have professional branding across all platforms! 🚀*
