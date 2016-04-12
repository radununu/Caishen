# Section 508

In 1998, Congress amended the Rehabilitation Act of 1973 (29 U.S.C. 794d) to require federal agencies to make their electronic and information technology public content accessible to people with disabilities. Inaccessible technology interferes with an individual's ability to obtain and use information quickly and easily. Section 508 was enacted to eliminate barriers in information technology, to make available new opportunities for people with disabilities and to encourage development of technologies that will help achieve these goals.

[Source](http://www.gsa.gov/portal/content/105254)

## Requirements

Section 508 requires that when federal agencies develop, procure, maintain, or use electronic and information technology, federal employees with disabilities have access to and use of information and data that is comparable to the access and use by federal employees who are not individuals with disabilities, unless an undue burden would be imposed on the agency. Section 508 also requires that individuals with disabilities, who are members of the public seeking information or services from a federal agency, have access to and use of information and data that is comparable to that provided to the public who are not individuals with disabilities, unless an undue burden would be imposed on the agency.

[Source](http://www.gsa.gov/portal/content/105254)

## Compliance

In order to comply to Section 508, Caishen makes use of the accessibility features included in iOS.

* Entered card numbers are read when selecting the text field and when making changes to that number.
* Visually impaired users are provided with audible feedback of visual transitions, i.e. users will be notified that the month text field is selected after the number was entered and valid.
* Visual effects to notify users of invalid input are made accessible to visually impaired users by providing audible alerts. I.e. when entering an invalid card number, users will be notified that the card number was invalid and when entering an expiration date in the past, users will be notified that the card has already expired.

In order to be accessible to auditively impaired users, no further action has to be provided, as, per default, all feedback is accessible visually.

The **General Services Administration (GSA)** provides a [detailed list](http://www.gsa.gov/portal/getMediaData?mediaId=117694) of requirements for mobile apps to comply to Section 508:

| Requirement | Section 508 Mapping | Implementation |
|-------------|---------------------|----------------|
| **(1.1)** User elements must expose their interface type, name, position, behavior/state and value to assistive technologies. | 1194.21(a), 1194.21(c), 1194.21(d), 1194.31(a,b,f), Section 508 Refresh | Each view inside the Caishen card text field provides audible descriptions of its state by providing accessibility label, their type (text field) and the currently entered value. |
| **(1.2)** The application must not interfere or disrupt the platform accessibility application programming interface (API). | 1194.21(b), 1194.31(a,b,c,f) | ✔︎ |
| **(1.3)** Applications must allow assistive technologies to programmatically discover the current focus and properly announce when changes in focus occur. | 1194.21(a), 1194.21(c), 1194.31(a,b,f) | Changes to the current focus - whether initiated by the user or triggered automatically - are made accessible by describing the currently selected part of the text field when changing focus. |
| **(1.4)** When an image is used to identify a control, status indicator, or other programmatic element, the meaning assigned to the image must be consistent throughout an application. | 1194.21(e), 1194.31(a,b,f) | *(Custom images can be provided for the card field's accessory button. It is the developer's responsibility to fulfill this requirement)* |
| **(1.5)** Applications must use platform standard exit methods. | 1194.21(a), Section 508 Refresh | *(No exit methods required in Caishen)* |
| **(1.6)** Users must be able to quickly search, or use an index function when lists or tables contain more than 25 rows of data. | 1194.21(d), 1194.22(o), 1194.31(a,b,f) | *(No lists or tables in Caishen)* |
| **(1.7)** The state of interface elements must be discernible both visually and through assistive technology, without the user inadvertently changing the state of the object. | 1194.31(a,b,f) | All changes to any of the form fields are repeated audibly. |
| **(1.8)** Use high color contrast for images of text. If images of text are used, a text equivalent of the image must also be provided. | 1194.21(e), 1194.21(f), 1194.21(j), 1194.31(b) | *(No images of text in Caishen)* |
| **(1.9)** Applications must have sufficient color contrast OR provide a function for users to enhanced contrast. | 1194.21(e), 1194.21(f), 1194.21(j), 1194.31(b) | Caishen provides a fully customizable text field. Just like with every other text field in the application, it is the developer's responsibility to provide sufficient contrast between text, images and background. |
| **(1.10)** Applications must not use flashing or blinking at a frequency greater than 2 Hz and lower than 55 Hz. | 1194.21(k) | Caishen does not make use of any flashing or blinking animations. |
| **(1.11)** Any change in focus should properly inform the assistive technology as to the reason and purpose of the change. | 1194.21(c), 1194.21(d), 1194.31(a,b,f) | Tapping on a form field, as well as view animations that change text fields trigger an audible notification that provides information about the newly selected form field. |
| **(1.12)** The focus order should be logically driven by function and/or the content structure. | 1194.21(a), 1194.21(c), 1194.31(a,b,f) | The focus order in Caishen represents the order of elements on a payment card, starting with the card number on the top, followed by month and year below the number and finished by the card verification code on the back. |
| **(2.1)** Provide alternative text or descriptions for non-decorative images, images within a link, form fields, and other interface elements. | 1194.21(d), 1194.21(f), 1194.22(a), 1194.22(i), 1194.22(l), 1194.22(n), 1194.31(a,b) | Detected card types that are visually displayed on the card type image view are audibly presented when selecting the number text field. |
| **(2.2)** Associate descriptive and/or instructional text for links, form fields, and other interface elements. | 1194.21(d), 1194.21(f), 1194.22(a), 1194.22(i), 1194.22(l), 1194.22(n), 1194.31(a,b) | Audible descriptions for each text field are triggered as soon as the user taps on the respective text field. |
| **(2.3)**  Provide a functional, target-specific destination and/or purpose for links and user controls. When multiple links and controls have the same name (e.g., for multiple fields where ‘Edit’ links appear next to a list of records), provide a unique and target-specific description for each (e.g. ‘Edit Jack Shephard's record’, ‘Edit Kate Austen's record’, etc.). | 1194.21(d), 1194.21(f), 1194.22(a), 1194.22(l), 1194.31(a,b) | *(No multiple links and controls with the same name are used in Caishen.)* |
| **(2.4)** Use the text displayed in images of text as the alternative text. | 1194.21(d), 1194.22(a), 1194.22(l), 1194.31(a,b) | *(No text displayed in images within Caishen.)* |
| **(2.5)** Avoid repetition of image captions in an image’s alternative text. | 1194.21(d), 1194.22(a), 1194.22(l) | *(No image captions are used in Caishen.)* |
| **(2.6)** Supply a null alternative text value for decorative or formatting images so they are skipped by assistive technologies. | 1194.31(a,b) | *(No decorative or formatting images are used in Caishen.)* |
| **(2.7)** Provide detailed descriptions for complex images (charts, diagrams, figures, etc.). | 1194.22(a), 1194.31(a,b) | *(No complex images are used in Caishen.)* |
| **(2.8)** Provide single descriptions for tiled and layered images.  Where possible, combine or group separate images so they are associated with a single description. | 1194.22(a), 1194.31(a,b) | *(No tiled or layered images are used in Caishen.)* |
| **(2.9)** Information conveyed through color must also be conveyed textually. | 1194.21(i), 1194.22(c), 1194.31(a,b) | Invalid input either for the card expiration or card number is both indicated by a changing text color and an audible notification if VoiceOver is active. |
| **(3.1)** Alert users that a time out will occur, allow users to extend a time out, and convey how much time they will have to extend the time out. | 1194.21(c), 1194.22(p), 1194.31(a,b,f) | *(No timeouts are used in Caishen.)* |
| **(3.2)** After a time out is extended, return focus to where the user last had focus. | 1194.21(c), 1194.22(p), 1194.31(a,b,f) | *(No timeouts are used in Caishen.)* |
| **(3.3)** Alert users that the time out event has occurred. | 1194.21(c), 1194.22(p), 1194.31(a,b,f) | *(No timeouts are used in Caishen.)* |
| **(4.1)** Provide a programmatically determinable summary for tables. | 1194.21(d), 1194.22(a), 1194.31(a,b,f) | *(No tables are used in Caishen.)* |
| **(4.2)** Mark up column and row header cells so that they are exposed properly to the Assistive Technology. | 1194.21(d), 1194.22(g), 1194.22(h), 1194.31(a,b,f) | *(No tables are used in Caishen.)* |
| **(4.3)** When creating complex tables, ensure data cells are associated with the correct header cells. | 1194.21(d), 1194.22(g), 1194.22(h), 1194.31(a,b,f) | *(No tables are used in Caishen.)* |
| **(4.4)** Header columns must programmatically indicate if/how they are sorted. | 1194.21(d), 1194.22(g), 1194.22(h), 1194.31(a,b,f) | *(No tables are used in Caishen.)* |
