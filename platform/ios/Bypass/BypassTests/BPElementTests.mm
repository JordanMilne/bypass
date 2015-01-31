#import <XCTest/XCTest.h>
#import "BPElementPrivate.h"

@interface BPElementTests : XCTestCase
@end

@implementation BPElementTests
{
    BPElement *element;
}

- (void)setUp
{
    using namespace Bypass;
    
    Element e0;
    e0.setType(PARAGRAPH);
    e0.setText("text");
    e0.addAttribute("a", "A");
    e0.addAttribute("b", "B");
    
    Element e1;
    e1.setType(TEXT);
    e1.setText("one ");
    e0.append(e1);
    
    Element e2;
    e2.setType(DOUBLE_EMPHASIS);
    e2.setText("two");
    e0.append(e2);
    
    Element e3;
    e3.setType(TEXT);
    e3.setText(" three");
    e0.append(e3);
    
    element = [[BPElement alloc] initWithElement:e0];
}

- (void)testInitialization
{
    XCTAssertNotNil(element, @"Expected non-nil element");
}

- (void)testElementTypeAccessor
{
    XCTAssertEqual([element elementType], BPParagraph, @"Expected same type");
}

- (void)testTextAccessor_forObjectEquality
{
    XCTAssertEqualObjects([element text], @"text", @"Expected equivalent text");
}

- (void)testTextAccessor_forPointerEquality
{
    NSString *text = [element text];
    XCTAssertEqual([element text], text, @"Expected same string");
}

- (void)testAttributeAccessor_forObjectEquality
{
    NSDictionary *expected = @{@"a": @"A", @"b": @"B"};
    XCTAssertEqualObjects([element attributes], expected, @"Expected equivalent attributes");
}

- (void)testAttributeAccessor_forPointerEquality
{
    NSDictionary *attributes = [element attributes];
    XCTAssertEqual([element attributes], attributes, @"Expected same attributes");
}

- (void)testChildAccessor_forPointerEquality
{
    NSArray *childElements = [element childElements];
    XCTAssertEqual([element childElements], childElements, @"Expected same child elements");
}

- (void)testChildElements
{
    XCTAssertEqual([[element childElements] count], 3U, @"Expected 3 child elements");
    XCTAssertEqual([[element childElements][0] elementType], BPText, @"Expected first element type to be BPText");
    XCTAssertEqual([[element childElements][1] elementType], BPDoubleEmphasis, @"Expected second element type to be BPDoubleEmphasis");
    XCTAssertEqual([[element childElements][2] elementType], BPText, @"Expected third element type to be BPText");
}

- (void)testIsBlockElementAccessor
{
    XCTAssertEqual([element isBlockElement], YES, @"Expected a block element");
    XCTAssertEqual([[element childElements][0] isBlockElement], NO, @"Expected a span element");
}

- (void)testForParentElement
{
    BPElement *child = [element childElements][0];
    XCTAssertEqual([child parentElement], element, @"Expected parent element to be specified");
}

#if __has_feature(objc_subscripting)

- (void)testNumericSubscripting
{
    XCTAssertEqual(element[0], [[element childElements] objectAtIndex:0], @"Expected element subscripting to return a child element");
}

- (void)testAlphabeticSubscripting
{
    XCTAssertEqualObjects(element[@"a"], @"A", @"Expected alphabetic subscripting to return an attribute");
}

#endif

@end
