import { ParsedPresentationAttr, ParsedCoreAttr, ParsedStyleAttr, Style } from "./svgParser";
import { Assoc } from "./svg";
import { omit } from "./utils";

export const SVG_NS = "http://www.w3.org/2000/svg";
export const XLINK_NS = "http://www.w3.org/1999/xlink";

export const PATH_COMMAND_CHARS = "mlhvcsqtazMLHVCSQTAZ";

export const BASE_ATTRS_NULLS: () => ParsedCoreAttr & ParsedStyleAttr = () => {return{
    class: null,
    style: null,
    id: null,
    unknown: <Assoc>{}
}};

export const PRESENTATION_ATTRS_NULLS: ParsedPresentationAttr = Object.freeze({
    fill: null,
    "fill-rule": null,
    stroke: null,
    "stroke-width": null,
    "stroke-linecap": null,
    "stroke-linejoin": null,
    "stroke-dasharray": null,
    "stroke-dashoffset": null,
    transform: null,
    "font-family": null,
    "font-size": null,
    "font-style": null,
    "font-weight": null
});

export const STYLE_NULLS: () => Style = () => {return{
    type: "style",
    unknown: {},
    ...omit(PRESENTATION_ATTRS_NULLS, "transform")
}}


